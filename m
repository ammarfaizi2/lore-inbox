Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132935AbRDRAc4>; Tue, 17 Apr 2001 20:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132936AbRDRAcq>; Tue, 17 Apr 2001 20:32:46 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:15516 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S132935AbRDRAcg>;
	Tue, 17 Apr 2001 20:32:36 -0400
Message-ID: <3ADCE0A5.A05AFCAB@mandrakesoft.com>
Date: Tue, 17 Apr 2001 20:32:37 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-19mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jaquemet Loic <jal@fleming.u-psud.fr>
Cc: Vibol Hou <vhou@khmer.cc>, Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 
In-Reply-To: <NDBBKKONDOBLNCIOPCGHIEHBGDAA.vhou@khmer.cc> <3ADCDF38.5DD2CBB1@fleming.u-psud.fr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jaquemet Loic wrote:
> I've got a similar problem with a  RTL-8139 (rev 10) ( 8139too.c )
> Apr 17 22:53:12 skippy kernel: eth1: Too much work at interrupt,
> IntrStatus=0x0040.
> 
> The maintenair of this module writes that's a RxFIIFO Overflow that have
> probably no other issue than buying a new processor :)
> But .. I didn't have this messages on pre - 2.4.3 kernels .. ( neither on
> 2.4.3ac7 )

That's a different issue than the poster is having, it's two totally
different network cards with different characteristics.  I don't
remember telling you that status code is a RxFIFO overflow, though :)

The RxFIFO overflow code definitely needs changing -- that's the next
item on the list.

-- 
Jeff Garzik       | "Give a man a fish, and he eats for a day. Teach a
Building 1024     |  man to fish, and a US Navy submarine will make sure
MandrakeSoft      |  he's never hungry again." -- Chris Neufeld
