Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131588AbRDFMvw>; Fri, 6 Apr 2001 08:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131603AbRDFMvm>; Fri, 6 Apr 2001 08:51:42 -0400
Received: from pc57-cam4.cable.ntl.com ([62.253.135.57]:8334 "EHLO
	kings-cross.london.uk.eu.org") by vger.kernel.org with ESMTP
	id <S131588AbRDFMvi>; Fri, 6 Apr 2001 08:51:38 -0400
X-Mailer: exmh version 2.1.1 10/15/1999 (debian)
To: David Woodhouse <dwmw2@infradead.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: syslog insmod please! 
In-Reply-To: Message from David Woodhouse <dwmw2@infradead.org> 
   of "Fri, 06 Apr 2001 12:53:35 BST." <693.986558015@redhat.com> 
In-Reply-To: <Pine.LNX.4.30.0104051751410.20174-100000@andrew.triumf.ca>  <693.986558015@redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 06 Apr 2001 13:50:29 +0100
From: Philip Blundell <philb@gnu.org>
Message-Id: <E14lVh8-0005op-00@kings-cross.london.uk.eu.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I'm not wonderfully impressed with the way that you can't load the FPU 
>emulation module on ARM at the moment without having some form of FPU 
>emulation in your kernel already, either :)

Floating point on ARM is indeed something of a crock, but that particular case
used to work -- can you tell where it's going wrong?  See entry-armv.S, 
about line 680, for the very bad hack that was supposed to facilitate this 
kind of thing.

p.

