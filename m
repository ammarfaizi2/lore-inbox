Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268700AbUJPLgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268700AbUJPLgi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 07:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268702AbUJPLgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 07:36:38 -0400
Received: from 1-1-4-25a.lio.sth.bostream.se ([82.182.83.86]:22914 "EHLO
	pefyra") by vger.kernel.org with ESMTP id S268700AbUJPLgf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 07:36:35 -0400
Subject: Re: PROBLEM: 2.6.9-rc3, i8042.c: Can't read CTR while initializing
	i8042
From: =?ISO-8859-1?Q?H=E5kan?= Lindqvist <lindqvist@netstar.se>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1097079186.29255.53.camel@localhost.localdomain>
References: <4161A2C1.8000901@hccnet.nl>
	 <1097079186.29255.53.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-15
Date: Sat, 16 Oct 2004 13:37:09 +0200
Message-Id: <1097926629.2715.10.camel@pefyra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On ons, 2004-10-06 at 17:13 +0100, Alan Cox wrote:
> For E7xxx systems you need to disable USB legacy support in the BIOS
> because SMM only works on the boot processor. There is a patch to
> automate it in 2.6.8.1-ac you can also borrow

For the record, having to disable USB legacy for i8042 initialization to
work reliably also seems to apply to my i850 based motherboard (Asus
P4T533-C).

(About four out of five boots the i8042 initialization fails with
vanilla 2.6.9-rc3 when USB legacy is enabled.)


Thanks,
Håkan

