Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291927AbSBTPgK>; Wed, 20 Feb 2002 10:36:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291930AbSBTPgA>; Wed, 20 Feb 2002 10:36:00 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:50444 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S291927AbSBTPfw>; Wed, 20 Feb 2002 10:35:52 -0500
Date: Wed, 20 Feb 2002 10:34:36 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: secure erasure of files?
In-Reply-To: <Pine.LNX.4.30.0202121409150.18597-100000@mustard.heime.net>
Message-ID: <Pine.LNX.3.96.1020220103146.23280B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Feb 2002, Roy Sigurd Karlsbakk wrote:

> Does anyone know if it'll be hard to enable a <em>secure</em> deletion of
> files? What I mean is not merely overwriting it with NULLs, but rather
> using a more sophisticated overwrite, like the IBAS ExpertEraser software
> (http://www.ibas.com/erasure/)
> 
> Is this hard/possible/doable?

If you want to prevent casual reads with user tools which don't physically
destroy the hardware, a single overwrite is probablt fine. If you think
someone would want the info enough to take the drive apart, encrypt
everything including swap and tmp, using DES3 or similar extremely hard
code.

You have to know your exposure, who will try to recover the data and how
hard they will try.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

