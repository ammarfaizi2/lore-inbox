Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262594AbTCMXPW>; Thu, 13 Mar 2003 18:15:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262600AbTCMXPW>; Thu, 13 Mar 2003 18:15:22 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:64520 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262594AbTCMXPR>; Thu, 13 Mar 2003 18:15:17 -0500
Date: Thu, 13 Mar 2003 15:24:04 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
cc: "Randy.Dunlap" <rddunlap@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.63 accesses below %esp (was: Re: ntfs OOPS (2.5.63)) 
In-Reply-To: <200303132107.h2DL7DAK005848@eeyore.valparaiso.cl>
Message-ID: <Pine.LNX.4.44.0303131522390.23207-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 13 Mar 2003, Horst von Brand wrote:
>
> No need. Just dump some bytes before EIP raw, plus raw bytes + decoded
> after EIP. Could be of some help.

Alpha does this. Of course, there you don't have any of the partial 
instruction issues.

		Linus

