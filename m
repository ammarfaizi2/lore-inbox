Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261868AbSKMPhl>; Wed, 13 Nov 2002 10:37:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261900AbSKMPhl>; Wed, 13 Nov 2002 10:37:41 -0500
Received: from gate.in-addr.de ([212.8.193.158]:62482 "HELO mx.in-addr.de")
	by vger.kernel.org with SMTP id <S261868AbSKMPhk>;
	Wed, 13 Nov 2002 10:37:40 -0500
Date: Wed, 13 Nov 2002 16:44:44 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: Beau Kuiper <rugger@arach.net.au>, linux-kernel@vger.kernel.org
Subject: Re: PATCH: Pusedo-random pid generation (not really serious)
Message-ID: <20021113154444.GE21797@marowsky-bree.de>
References: <200211132330.36139.rugger@arach.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200211132330.36139.rugger@arach.net.au>
User-Agent: Mutt/1.4i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-11-13T23:30:36,
   Beau Kuiper <rugger@arach.net.au> said:

> This patch isn't designed to add security and/or unpredictability into pid 
> creation. It simply is trying to avoid using the same pids all the time, 
> which confused programs that used lock files.

Those programs are royally broken, they at least need to verify that the PID
stored actually refers to itself.

Be happy that you find out about such broken behaviour immediately and fix the
programs.

> The linear random number generator here has a period of 2^31, and statisticly, 
> its pretty ok.

> Since I know that this will NEVER make it into a standard kernel, I simply 
> post it for people who might find it useful. People like me, who use Kmail 
> and are not very particular about shutting down carefully 8-)

Fix kmail.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
Principal Squirrel 
SuSE Labs - Research & Development, SuSE Linux AG
  
"If anything can go wrong, it will." "Chance favors the prepared (mind)."
  -- Capt. Edward A. Murphy            -- Louis Pasteur
