Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290624AbSA3Vc6>; Wed, 30 Jan 2002 16:32:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290623AbSA3Vcs>; Wed, 30 Jan 2002 16:32:48 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:43783 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S290629AbSA3Vci>; Wed, 30 Jan 2002 16:32:38 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC] x86 ELF bootable kernels/Linux booting Linux/LinuxBIOS
Date: 30 Jan 2002 13:32:01 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a39ooh$lb3$1@cesium.transmeta.com>
In-Reply-To: <m1elk7d37d.fsf@frodo.biederman.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <m1elk7d37d.fsf@frodo.biederman.org>
By author:    ebiederm@xmission.com (Eric W. Biederman)
In newsgroup: linux.dev.kernel
> 
> - Code at that entry point to query from the firmware/BIOS the
>   information the kernel needs.
> 

How do you query from the 16-bit firmware/BIOS at the 32-bit
entrypoint?  Or is it that you have a table, fixed by protocol, of
what information is available (so we're basically fucked when
something needs to change)?

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
