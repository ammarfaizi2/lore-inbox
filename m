Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750844AbWJ0XXk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750844AbWJ0XXk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 19:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbWJ0XXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 19:23:40 -0400
Received: from main.gmane.org ([80.91.229.2]:3220 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750837AbWJ0XXj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 19:23:39 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: [PATCH ??] Re: incorrect taint of ndiswrapper
Date: Fri, 27 Oct 2006 23:23:01 +0000 (UTC)
Organization: Palacky University in Olomouc, experimental physics department.
Message-ID: <slrnek55j7.39b.olecom@flower.upol.cz>
References: <1161807069.3441.33.camel@dv> <1161808227.7615.0.camel@localhost.localdomain> <20061025205923.828c620d.akpm@osdl.org> <20061026102630.ad191d21.randy.dunlap@oracle.com> <1161959020.12281.1.camel@laptopd505.fenrus.org> <20061027082741.8476024a.randy.dunlap@oracle.com> <20061027112601.dbd83c32.akpm@osdl.org> <45428EAD.6040005@gmail.com> <1161990307.16839.50.camel@localhost.localdomain>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: flower.upol.cz
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>, Oleg Verych <olecom@flower.upol.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Florin Malita <fmalita@gmail.com>, Andrew Morton <akpm@osdl.org>, Randy Dunlap <randy.dunlap@oracle.com>, Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org, proski@gnu.org, cate@debian.org, gianluca@abinetworks.biz
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006-10-27, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> Ar Gwe, 2006-10-27 am 18:56 -0400, ysgrifennodd Florin Malita:
>> Also, since driverloader is not GPL-compatible (MODULE_LICENSE("see
>> LICENSE file; Copyright (c)2003-2004 Linuxant inc.")), that check is
>> redundant. How about removing it (applies on top of Randy's patch)?
>> 
>> 
>> Signed-off-by: Florin Malita <fmalita@gmail.com>
>
> NAK
>
> Older versions of Linuxant's driverloader claim GPL\0some other text and
> systematically set out to abuse the license tag code. We should continue
> to carry the code for this.
>
> Alan
>
ACK this NACK.

Please, do not forget:
Message-ID: <Pine.LNX.4.58.0404301401420.18014@ppc970.osdl.org>
<http://permalink.gmane.org/gmane.linux.kernel/201265>
____

