Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316795AbSIEE2j>; Thu, 5 Sep 2002 00:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316853AbSIEE2j>; Thu, 5 Sep 2002 00:28:39 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:7943 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316795AbSIEE2h>; Thu, 5 Sep 2002 00:28:37 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch] Make new keyboard code work on x86-64
Date: 4 Sep 2002 21:33:02 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <al6mpu$qql$1@cesium.transmeta.com>
References: <20020901220332.A74737@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20020901220332.A74737@ucw.cz>
By author:    Vojtech Pavlik <vojtech@suse.cz>
In newsgroup: linux.dev.kernel
>
> Hi!
> 
> An ifdef needs to be added for x86-64 so that i8042.c works on it as
> well:
> 

It seems that we really want is a PLATFORM_PC define here...

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
