Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264433AbRF1VRx>; Thu, 28 Jun 2001 17:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264447AbRF1VRn>; Thu, 28 Jun 2001 17:17:43 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:48024 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S264433AbRF1VRg>;
	Thu, 28 Jun 2001 17:17:36 -0400
Message-ID: <3B3B9F11.D83BDFDF@mandrakesoft.com>
Date: Thu, 28 Jun 2001 17:18:09 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: tom_gall@vnet.ibm.com
Cc: =?iso-8859-1?Q?G=E9rard?= Roudier <groudier@club-internet.fr>,
        linux-kernel@vger.kernel.org
Subject: Re: RFC: Changes for PCI
In-Reply-To: <20010628223210.Q1578-100000@> <3B3B9D83.F95D4496@vnet.ibm.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Gall wrote:
> Gérard Roudier wrote:
> > The driver checks against PCI bus+dev+func in 2 situations:
> >
> > 1) To apply the boot order that user can set up in the controller NVRAMs.
> > 2) To detect buggy double reporting of the same device by the kernel PCI
> >    code (this made lot of troubles at some time).
> 
> Thanks much for the clarification. Do you still battle buggy double reporting?
> Has this been fixed? Is it a bug on some specific architecture?

I've seen it occur in 2.2.x in buggy drivers, but in 2.4 the driver
should -not- have to check for this.  The PCI core takes care of it.

-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
