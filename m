Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264932AbRGELzI>; Thu, 5 Jul 2001 07:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264933AbRGELy6>; Thu, 5 Jul 2001 07:54:58 -0400
Received: from t2.redhat.com ([199.183.24.243]:44275 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S264932AbRGELyu>; Thu, 5 Jul 2001 07:54:50 -0400
Message-ID: <3B44558A.B52B5C60@redhat.com>
Date: Thu, 05 Jul 2001 12:54:50 +0100
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-11.3smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Vasu Varma P V <pvvvarma@techmas.hcltech.com>,
        linux-kernel@vger.kernel.org
Subject: Re: DMA memory limitation?
In-Reply-To: <3B4453E6.F4342781@techmas.hcltech.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vasu Varma P V wrote:
> 
> Hi,
> 
> Is there any limitation on DMA memory we can allocate using
> kmalloc(size, GFP_DMA)? I am not able to acquire more than
> 14MB of the mem using this on my PCI SMP box with 256MB ram.
> I think there is restriction on ISA boards of 16MB.
> Can we increase it ?

Why?
YOu don't have to allocate GFP_DMA memory for PCI cards!
GFP_DMA is for ISA cards only
