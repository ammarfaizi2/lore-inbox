Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270387AbRILWPX>; Wed, 12 Sep 2001 18:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271055AbRILWPO>; Wed, 12 Sep 2001 18:15:14 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:36619 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S270387AbRILWPG>; Wed, 12 Sep 2001 18:15:06 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: User Space Emulation of Devices
Date: 12 Sep 2001 15:14:57 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9nomp1$jt7$1@cesium.transmeta.com>
In-Reply-To: <54045BFDAD47D5118A850002A5095CC30AC57D@exchange1.cam.pace.co.uk> <20010912122826.A6153@bug.ucw.cz> <20010912214444Z271795-760+12170@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20010912214444Z271795-760+12170@vger.kernel.org>
By author:    Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
In newsgroup: linux.dev.kernel
> 
> How do you pass an ioctl ? If any parameter is a pointer you actually need a 
> complex protocol for passing memory content to make it useful.
> 

You need a parameter marshalling system; however, they do exist.  It
might actually be that the best way to deal with this is to make a
general module framework and compile a specific module to marshall the
parameters of the device you want to emulate.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
