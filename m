Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266486AbUH1Ds7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266486AbUH1Ds7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 23:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266487AbUH1Ds7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 23:48:59 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:24028 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266486AbUH1Ds5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 23:48:57 -0400
Subject: Re: reverse engineering pwcx
From: Lee Revell <rlrevell@joe-job.com>
To: Craig Milo Rogers <rogers@isi.edu>
Cc: QuantumG <qg@biodome.org>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040828033552.GN24018@isi.edu>
References: <412FD751.9070604@biodome.org> <20040828012055.GL24018@isi.edu>
	 <20040828014931.GM24018@isi.edu> <412FF888.8090307@biodome.org>
	 <20040828033552.GN24018@isi.edu>
Content-Type: text/plain
Message-Id: <1093664940.8611.8.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 27 Aug 2004 23:49:00 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-08-27 at 23:35, Craig Milo Rogers wrote:
> On 04.08.28, QuantumG wrote:
> > Craig Milo Rogers wrote:
> > 
> > >	Hmmm... a poster on Slashdot claims that entropy measurements
> > >imply that the pwcx code is interpolating rather that truly
> > >decompressing.  Again, that's integer math and table lookups.
> > > 
> > >
> > 
> > http://www.amazon.com/exec/obidos/tg/detail/-/B00005R098/102-7619892-0201738?v=glance
> > 
> > claims that the Logitech Quickcam Pro 3000 is a "True 640 x 480 
> > resolution video capture" which is now clearly false.
> 
> 	If the "now clearly false" is meant to be a consequence of the
> entropy measurements poster I referred to, I wouldn't jump the gun.
> On reflection, it's entirely natural for a decompressed stream to
> examine less entropy than the corresponding compressed stream!
> 

Please see this slashdot thread:

http://linux.slashdot.org/comments.pl?sid=119578&threshold=3&mode=flat&commentsort=0&op=Change

The LavaRnd guys examined the pixels on the actual CCD chip.  It's
160x120.  The 'decompression' is just interpolation.

Lee


