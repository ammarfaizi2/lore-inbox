Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271901AbRH2Emr>; Wed, 29 Aug 2001 00:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271902AbRH2Emi>; Wed, 29 Aug 2001 00:42:38 -0400
Received: from rj.sgi.com ([204.94.215.100]:54918 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S271901AbRH2EmX>;
	Wed, 29 Aug 2001 00:42:23 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: David Findlay <david_j_findlay@yahoo.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: Bug in 2.4.9: Joydev module has incorrect version number 
In-Reply-To: Your message of "Wed, 29 Aug 2001 13:35:34 +1000."
             <200108290336.f7T3aCIG002344@ADSL-Server.davsoft.com.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 29 Aug 2001 14:42:21 +1000
Message-ID: <22845.999060141@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Aug 2001 13:35:34 +1000, 
David Findlay <david_j_findlay@yahoo.com.au> wrote:
>I am using kernel 2.4.9. All the joystick stuff is in using the M options. 
>When going modprobe joydev it can't find it. When using insmod to specifiy 
>the exact name of the file, it says that it can't find the correct kernel 
>version.

Fixed in the -ac tree, waiting for the joystick/input mainatiner to
push the changes to Linus.  Prod the maintainer.

>I'd also like to ask for 2.6 to have a feature that will automatically detect 
>all hardware, and load the correct drivers. I'm sick of having to do all 
>sorts of stuff to get hardware to go. Why can't it just work? Thanks,

kbuild 2.5 includes CML2 which, together with Giacomo Catenazzi's
autprobe code, makes it much easier to automatically build a kernel for
your hardware.

