Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316251AbSEQOon>; Fri, 17 May 2002 10:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316254AbSEQOom>; Fri, 17 May 2002 10:44:42 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27921 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316251AbSEQOoj>;
	Fri, 17 May 2002 10:44:39 -0400
Message-ID: <3CE516E4.4000500@mandrakesoft.com>
Date: Fri, 17 May 2002 10:42:44 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/00200203
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: ink@jurassic.park.msu.ru, andrew.grover@intel.com, mochel@osdl.org,
        Greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: pci segments/domains
In-Reply-To: <3CE512A7.70202@mandrakesoft.com>	<20020517.071633.67125480.davem@redhat.com>	<3CE514B6.6070302@mandrakesoft.com> <20020517.072625.29433758.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:

>   From: Jeff Garzik <jgarzik@mandrakesoft.com>
>   Date: Fri, 17 May 2002 10:33:26 -0400
>
>   My main want is cosmetic -- call a spade a spade, so to speak. 
>    s/sysdata/pci_domain/  But doing so opens the door to increased 
>   flexibility.  Later steps can add common members needed by pci-to-pci 
>   IOMMU tricks which are common to most platforms.
>
>Since the name really doesn't matter let's call it struct pci_controller
>since that is what Alpha and Sparc use already :-)
>


Makes sense, sure :)  I just want to get rid of the untyped sysdata in 
favor of a struct with a defined type (arch-defined... but named and 
defined nonetheless).

    Jeff



