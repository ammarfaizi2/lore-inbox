Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751196AbVKKVGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbVKKVGn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 16:06:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbVKKVGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 16:06:43 -0500
Received: from rtsoft2.corbina.net ([85.21.88.2]:41647 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S1751196AbVKKVGm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 16:06:42 -0500
Message-ID: <43750851.1080306@ru.mvista.com>
Date: Sat, 12 Nov 2005 00:08:33 +0300
From: Sergei Shtylylov <sshtylyov@ru.mvista.com>
Organization: MostaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: hpt366 driver oops or panic with HighPoint RocketRAID 1520	SATA
 (HPT372N)
References: <436FB350.6020309@inap.se> <1131467876.25192.51.camel@localhost.localdomain>
In-Reply-To: <1131467876.25192.51.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Alan Cox wrote:

> I've got the correct timing tables and PLL tune information for the 302N
> now which appears to be very similar if not identical for these needs so
> if someone wants to hack the old drivers/ide/pci driver a bit I can
> provide reasonably accurate chip id and chip pll base information to
> enable a fix.

    I'm currently working on the old driver to bring in the HPT371N support 
and fix HPT371 clock setup (and make the other chip's clock setups correct 
along the way). Unfortunately I can test only on 371N and 370A, the board with 
371 soldered in has PCI contreoller fried.

WBR, Sergei
