Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269166AbUI2XZJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269166AbUI2XZJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 19:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269186AbUI2XZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 19:25:09 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:62901 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S269166AbUI2XYz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 19:24:55 -0400
Date: Wed, 29 Sep 2004 16:25:58 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Hanna Linder <hannal@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kernel-janitors@lists.osdl.org, greg@kroah.com, kraxel@bytesex.org
Subject: Re: [PATCH 2.6.9-rc2-mm4 zr36120.c][5/8] Convert pci_find_device	to pci_dev_present
Message-ID: <24740000.1096500358@w-hlinder.beaverton.ibm.com>
In-Reply-To: <1096496127.16721.10.camel@localhost.localdomain>
References: <19730000.1096496900@w-hlinder.beaverton.ibm.com> <1096496127.16721.10.camel@localhost.localdomain>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Wednesday, September 29, 2004 11:15:30 PM +0100 Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Mer, 2004-09-29 at 23:28, Hanna Linder wrote:
>> The dev was not used from pci_find_device so it was acceptable to replace
>> with pci_dev_present. There was no need for it to be in a while loop originally.
>> Compile tested.
> 
> That code should die I think. All the tests it does are done in
> pci/quirks.c and set up pci_pci_flags
> 
> 

The whole driver is CONFIG_BROKEN anyway... I only verified my changes
didn't add new compiler errors. What part should I remove? Just this check?

Thanks.

Hanna


