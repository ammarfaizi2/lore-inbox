Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267163AbSLEAsw>; Wed, 4 Dec 2002 19:48:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267166AbSLEAsw>; Wed, 4 Dec 2002 19:48:52 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59396 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267163AbSLEAsu>;
	Wed, 4 Dec 2002 19:48:50 -0500
Message-ID: <3DEEA417.5080006@pobox.com>
Date: Wed, 04 Dec 2002 19:55:51 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Adam J. Richter" <adam@yggdrasil.com>
CC: James.Bottomley@SteelEye.com, davem@redhat.com,
       linux-kernel@vger.kernel.org, miles@gnu.org
Subject: Re: [RFC] generic device DMA implementation
References: <200212050043.QAA03207@adam.yggdrasil.com>
In-Reply-To: <200212050043.QAA03207@adam.yggdrasil.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam J. Richter wrote:
> On 2002-12-04, James Bottomley wrote:
> 
> 
>>Now that we have the generic device model, it should be equally possible to 
>>rephrase the entire [DMA] API for generic devices instead of pci_devs.
> 
> 
> 	Yes.  This issue has come up repeatedly.  I'd really like to
> see a change like yours integrated soon to stop the spread of fake PCI
> devices (including the pcidev==NULL convention) and other contortions
> being used to work around this.  Also, such a change would enable
> consolidation of certain memory allocations and their often buggy
> error branches from hundred of drivers into a few places.


Agreed.  I'm glad James is doing this work, it will clean up a lot of 
assumptions and corner-case-uglies...

	Jeff



