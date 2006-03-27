Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751605AbWC0ERf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751605AbWC0ERf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 23:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751591AbWC0ERf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 23:17:35 -0500
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:32759 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S1750738AbWC0ERe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 23:17:34 -0500
Message-ID: <019d01c65155$57f323a0$4168010a@bsd.tnes.nec.co.jp>
From: "Takashi Sato" <sho@bsd.tnes.nec.co.jp>
To: "Badari Pulavarty" <pbadari@us.ibm.com>
Cc: <Ext2-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
References: <20060325223358sho@rifu.tnes.nec.co.jp> <442717A6.3060708@us.ibm.com>
Subject: Re: [Ext2-devel] [PATCH 2/2] ext2/3: Support2^32-1blocks(e2fsprogs)
Date: Mon, 27 Mar 2006 13:17:16 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Sure. I will give it a spin.
> 
> BTW, did you really test them with > 8TB filesystem ?
> I ran bunch of "dd"s to create few files and then ran mutiple copies of 
> "fsx" tests.
> Then I run into problems in few seconds of the tests.

I ran five fsx programs and five dd to create 400MB-files
concurrently on 9TB filesystem, and no problem occurred.

--
Takashi Sato
