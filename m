Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290959AbSBFXg2>; Wed, 6 Feb 2002 18:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290958AbSBFXgT>; Wed, 6 Feb 2002 18:36:19 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:10512 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S290953AbSBFXgI>; Wed, 6 Feb 2002 18:36:08 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: kernel: ldt allocation failed
Date: 6 Feb 2002 15:35:35 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a3sek7$h6n$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.4.21.0112070057480.20196-100000@tombigbee.pixar.com.suse.lists.linux.kernel> <20020206163118.E21624@devserv.devel.redhat.com> <3C61A8C0.7000406@zytor.com> <20020206172025.H21624@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20020206172025.H21624@devserv.devel.redhat.com>
By author:    Jakub Jelinek <jakub@redhat.com>
In newsgroup: linux.dev.kernel
>
> Unlike d) with LDT, where unmodified glibc could work with older kernels
> too, thus would mean strict kernel minimum version requirement (with LDT d)
> it would be just an optimization).
> 

Just make it a fallback option.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
