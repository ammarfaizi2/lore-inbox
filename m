Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317836AbSHGLKF>; Wed, 7 Aug 2002 07:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317898AbSHGLKF>; Wed, 7 Aug 2002 07:10:05 -0400
Received: from cygnus-ext.enyo.de ([212.9.189.162]:38415 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id <S317836AbSHGLKD>;
	Wed, 7 Aug 2002 07:10:03 -0400
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, gam3@acm.org
Subject: Re: Problems with NFS exports
References: <87eldchtr2.fsf@deneb.enyo.de> <87k7n3t3zm.fsf@deneb.enyo.de>
	<15696.63765.38094.618742@notabene.cse.unsw.edu.au>
From: Florian Weimer <fw@deneb.enyo.de>
Mail-Followup-To: Neil Brown <neilb@cse.unsw.edu.au>,
 linux-kernel@vger.kernel.org,  gam3@acm.org
Date: Wed, 07 Aug 2002 13:13:38 +0200
In-Reply-To: <15696.63765.38094.618742@notabene.cse.unsw.edu.au> (Neil
 Brown's message of "Wed, 7 Aug 2002 20:40:21 +1000")
Message-ID: <8765ymsyzh.fsf@deneb.enyo.de>
User-Agent: Gnus/5.090007 (Oort Gnus v0.07) Emacs/21.2 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown <neilb@cse.unsw.edu.au> writes:

> Probably better documentation in exports.5 would be just as useful.

Maybe.

BTW, is it possible to export a directory tree under a different path,
using the kernel NFS daemon?

> And "BUSY" probably isn't correct ....

Why not? The ressource (the directory tree) is already being used, and
therefore the export fails.

> It would be possible to dis-ambiguate the ambiguity but it wouldn't be
> very clean, and I really am not sure that it is worth the effort.

Better error messages are always a good idea. :-)
