Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261707AbUKHACd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261707AbUKHACd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 19:02:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261718AbUKHACc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 19:02:32 -0500
Received: from mail2.epfl.ch ([128.178.50.133]:11781 "HELO mail2.epfl.ch")
	by vger.kernel.org with SMTP id S261707AbUKHACa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 19:02:30 -0500
Date: Mon, 8 Nov 2004 01:02:29 +0100
From: Gregoire Favre <Gregoire.Favre@freesurf.ch>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why my computer freeze completely with xawtv ?
Message-ID: <20041108000229.GC5360@magma.epfl.ch>
References: <20041107224621.GB5360@magma.epfl.ch> <418EB58A.7080309@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <418EB58A.7080309@kolivas.org>
User-Agent: Mutt/1.5.6i
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2004 at 10:53:46AM +1100, Con Kolivas wrote:

Hello again :-)

> Gregoire Favre wrote:
> >I use DVB with VDR, but I can do the crash all the time without VDR, all
> >I have to do is to have xawtv running and having a process that write
> >fast enough data to an HD (I tested xfs, reiserfs, ext2 and ext3 with
> >same result). If I don't have xawtv running I can't make crashing my
> >system which is rock stable :-)
> 
> Is xawtv running as root or with real time privileges? That could do it.

Normally I start xawtv this way:
xawtv -c /dev/v4l/video0 -geometry 770x580-0-0 -xvport 61 & as a normal
user, but I don't know what real time privileges are ?
I haven't modified in any way xawtv :
-rwxr-xr-x  1 root root 243K Oct 12 09:36 /usr/bin/xawtv

I got the problem under my Mandrake Cooker, and now(due to amd64) I am
under a gentoo-amd64.

Thank you very much for your interest in my problem :-)

Plese keep CC to me as I am not on the LKML (read through NNTP).
-- 
	Grégoire Favre
________________________________________________________________________
http://magma.epfl.ch/greg ICQ:16624071 mailto:Gregoire.Favre@freesurf.ch
