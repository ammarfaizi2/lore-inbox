Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317610AbSGYHuX>; Thu, 25 Jul 2002 03:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317619AbSGYHuX>; Thu, 25 Jul 2002 03:50:23 -0400
Received: from 212.Red-80-35-44.pooles.rima-tde.net ([80.35.44.212]:640 "EHLO
	DervishD.pleyades.net") by vger.kernel.org with ESMTP
	id <S317610AbSGYHuX>; Thu, 25 Jul 2002 03:50:23 -0400
Date: Thu, 25 Jul 2002 10:00:53 +0200
Organization: Pleyades
To: hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: Header files and the kernel ABI
Message-ID: <3D3FB035.mailB014KTO5@viadomus.com>
References: <aho5ql$9ja$1@cesium.transmeta.com>
In-Reply-To: <aho5ql$9ja$1@cesium.transmeta.com>
User-Agent: nail 9.31 6/18/02
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
From: DervishD <raul@pleyades.net>
Reply-To: DervishD <raul@pleyades.net>
X-Mailer: DervishD TWiSTiNG Mailer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi HPA :)

>I would like to propose that these files be set up in the #include
>namespace as <linux/abi/*>, with <linux/abi/arch/*> for any
>architecture-specific support files (I do believe, however, that those
>files should only be included by files in the linux/abi/ root.  This
>probably would be a symlink to ../asm/abi in the kernel sources,
>unless we change the kernel include layout.)

    I think this is a *really* great idea. It will solve lots of
problems IMHO. Now the glibc copies some of the kernel headers, and
in the future it will support more, but standarizing an ABI set of
headers will be better (IMHO again). Go for it ;)

    Raúl
