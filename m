Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262446AbUADOKP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 09:10:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265512AbUADOKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 09:10:14 -0500
Received: from aun.it.uu.se ([130.238.12.36]:48307 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262446AbUADOKM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 09:10:12 -0500
Date: Sun, 4 Jan 2004 15:10:06 +0100 (MET)
Message-Id: <200401041410.i04EA61e007769@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: szepe@pinerecords.com
Subject: Re: Pentium M config option for 2.6
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Date: Sun, 4 Jan 2004 13:33:58 +0100, Tomas Szepe wrote:
> > IOW, don't lie to the compiler and pretend P-M == P4
> > with that -march=pentium4.
> 
> What do you recommend to use as march then?  There is
> no pentiumm subarch support in gcc yet;  I was convinced
> p4 was the closest match.

march=pentium3 is the closest safe choice, at least
until gcc implements P-M specific support.

/Mikael
