Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313576AbSDRP2P>; Thu, 18 Apr 2002 11:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314149AbSDRP2O>; Thu, 18 Apr 2002 11:28:14 -0400
Received: from gate.in-addr.de ([212.8.193.158]:32263 "HELO mx.in-addr.de")
	by vger.kernel.org with SMTP id <S313576AbSDRP2O>;
	Thu, 18 Apr 2002 11:28:14 -0400
Date: Thu, 18 Apr 2002 17:27:58 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Versioning File Systems?
Message-ID: <20020418172758.Q4498@marowsky-bree.de>
In-Reply-To: <20020418110558.A16135@borg.org> <20020418082025.N2710@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.22.1i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-04-18T08:20:25,
   Larry McVoy <lm@bitmover.com> said:

> It's certainly a fun space, file system hacking is always fun.  There
> doesn't seem to be a good match between file system operations and
> SCM operations, especially stuff like checkin.  write != checkin.
> But you can handle that with

Either that, or heuristics - file not written to / opened for writing in x
minutes -> commit.

That would actually be pretty interesting because it might also allow you to
back out editor screwups ;-)

However, deducing change sets is more difficult.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
Immortality is an adequate definition of high availability for me.
	--- Gregory F. Pfister

