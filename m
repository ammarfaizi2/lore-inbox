Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287919AbSABTwk>; Wed, 2 Jan 2002 14:52:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287931AbSABTwc>; Wed, 2 Jan 2002 14:52:32 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:39684 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S287919AbSABTwM>; Wed, 2 Jan 2002 14:52:12 -0500
Message-Id: <200201021951.g02Jpw4G017809@pincoya.inf.utfsm.cl>
To: timothy.covell@ashavan.org
cc: linux-kernel@vger.kernel.org
Subject: Re: system.map 
In-Reply-To: Message from Timothy Covell <timothy.covell@ashavan.org> 
   of "Wed, 02 Jan 2002 13:26:29 MDT." <200201021930.g02JUCSr021556@svr3.applink.net> 
Date: Wed, 02 Jan 2002 16:51:58 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Covell <timothy.covell@ashavan.org> said:

[...]

> 	Of course, you can copy over the new System.map
> file to /boot,  but their is no (easy) way of having more than
> one active version via "lilo" or "grub".   And that could be 
> considered a deficiency of the Linux OS.

For kernel 2.4.18pre1 call it /boot/System.map-2.4.18pre1. Everything gets
sorted out if your initscripts symlink that to /boot/System.map (uname(1)
gives you the version of the running kernel).
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
