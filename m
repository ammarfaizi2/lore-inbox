Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262501AbVCDHeA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262501AbVCDHeA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 02:34:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261281AbVCDHeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 02:34:00 -0500
Received: from de01egw01.freescale.net ([192.88.165.102]:29069 "EHLO
	de01egw01.freescale.net") by vger.kernel.org with ESMTP
	id S262501AbVCDHct convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 02:32:49 -0500
In-Reply-To: <c4b38ec405030321452996b084@mail.gmail.com>
References: <c4b38ec405030321452996b084@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <1645bfed02c6453427b8397682356690@freescale.com>
Content-Transfer-Encoding: 8BIT
Cc: <linux-kernel@vger.kernel.org>
From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: Does linux kernel support little-endian on powerpc?
Date: Fri, 4 Mar 2005 01:32:39 -0600
To: "David L" <abcd.bpmf@gmail.com>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No it does not and its extremely unlikely we will ever support 
little-endian, the list of pains this causes is endless.

- kumar

On Mar 3, 2005, at 11:45 PM, David L wrote:

> Hi All,
>
> I know toolchain support the target powerpcle-elf. it enable the
>  little-endian on powerpc. I see that there is -melf32ppc param for ld
>  in arch/ppc/Makefile. Can I modify it to -melf32lppc? what will occur?
>  Can kernel suport little-endian on powerpc well?
>
> thanks
>  Jason
>  -
>  To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>  Please read the FAQ at  http://www.tux.org/lkml/

