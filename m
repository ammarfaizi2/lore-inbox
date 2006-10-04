Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030822AbWJDLGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030822AbWJDLGU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 07:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030823AbWJDLGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 07:06:19 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:50506 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030821AbWJDLGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 07:06:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer;
        b=GFQdeyTkFR7dZ/abkzSRGeE88fKrbfCrMZcx3js49tjkIBUunMYh0mjYt+CM/FvJV5HudcJdJQ8SF42fa/LLBYkSeYpXWJpx17KZuZu3psqG5ODVUFMdaQt4xL9aN0cetE5a31cWVGShqghZ0XDZuBCccJDcm5RoQ0uFxlJPyXk=
In-Reply-To: <1159960645.25772.7.camel@localhost.localdomain>
References: <28EE04D1-1645-4D2C-9D8B-FB4877779223@gmail.com> <1159960645.25772.7.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v749)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F31D7E0B-1FCD-4A86-8160-4025B13CFE0E@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: girish <girishvg@gmail.com>
Subject: Re: PCI/IDE generic IDE driver + bus master DMA logic errors
Date: Wed, 4 Oct 2006 20:06:11 +0900
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
X-Mailer: Apple Mail (2.749)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Oct 4, 2006, at 8:17 PM, Alan Cox wrote:

> Ar Mer, 2006-10-04 am 19:07 +0900, ysgrifennodd girish:
>> our hardware guys are designing an pci/ide controller which has
>> interrupt wrapper such that the ide & bus master interrupts are
>> packaged & delivered together.
>
> All the SFF8038i/D1510 style devices have a single interrupt line for
> IDE and for bus mastering interrupts. If your device behaves in
> accordance to D1510 the default code ought to work.
>
> Alan

thanks alan. i will have look into it.

one more question - we are planning two channel bus-mastering design.  
whether linux ide sub-system will support simultaneous dma kick  
sequences?



