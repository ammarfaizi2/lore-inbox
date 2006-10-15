Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752441AbWJOE1c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752441AbWJOE1c (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 00:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752444AbWJOE1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 00:27:32 -0400
Received: from main.gmane.org ([80.91.229.2]:26521 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1752441AbWJOE1b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 00:27:31 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: sky2 (was Re: 2.6.18-mm2)
Date: Sun, 15 Oct 2006 04:27:05 +0000 (UTC)
Organization: Palacky University in Olomouc, experimental physics department.
Message-ID: <slrnej3egk.2kc.olecom@flower.upol.cz>
References: <20060928155053.7d8567ae.akpm@osdl.org> <451C5599.80402@garzik.org> <20060928161956.5262e5d3@freekitty> <1159930628.16765.9.camel@mhcln03> <20061003202643.0e0ceab2@localhost.localdomain> <1160250529.4575.7.camel@mhcln03> <1160314905.4575.21.camel@mhcln03> <20061008092001.0c83a359@localhost.localdomain> <1160326801.4575.27.camel@mhcln03> <1160332296.4575.31.camel@mhcln03> <20061009094504.7b58eb2d@freekitty> <slrneilm0q.3mc.olecom@deen.upol.cz.local>
Reply-To: Oleg Verych <olecom@flower.upol.cz>,
       LKML <linux-kernel@vger.kernel.org>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: flower.upol.cz
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006-10-09, Oleg Verych wrote:
> On 2006-10-09, Stephen Hemminger wrote:
>> On Sun, 08 Oct 2006 20:31:36 +0200
>> Matthias Hentges <oe@hentges.net> wrote:
>>
>>> 
>>> Oops, I forgot the "x" in lspci -vvvx, new dumps are attached.
>>
>>
>> I think I know what the problem is. The PCI access routines to access pci express
>> registers (ie reg > 256), only work if using MMCONFIG access. For some reason
>> your configuration doesn't want to use/allow that.
>
> In case you didn't read, here's top of thread about MMCONFIG 4 days ago:
><http://article.gmane.org/gmane.linux.ports.x86-64.general/1794>
>
> In short: due to Intel BIOS bug, mmconfig doesn't used in kernel.
> And kernel developers mainly do not care much (yet) about drivers, until
> vi$ta certified hardware will be in run.
> ____

[and, due to my dumb, not copied here Stephen's answer was:]

> Then I would argue that PCI express support is broken in the kernel.

____

