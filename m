Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129734AbRABNmu>; Tue, 2 Jan 2001 08:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129896AbRABNmk>; Tue, 2 Jan 2001 08:42:40 -0500
Received: from smtp4.ihug.co.nz ([203.109.252.5]:13575 "EHLO smtp4.ihug.co.nz")
	by vger.kernel.org with ESMTP id <S129734AbRABNmb>;
	Tue, 2 Jan 2001 08:42:31 -0500
Message-ID: <3A51D30F.F1AA5AD@ihug.co.nz>
Date: Wed, 03 Jan 2001 02:09:35 +1300
From: david <sector2@ihug.co.nz>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: kernel2.2.x get_vm_area
X-Priority: 2 (High)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi i and writing a driver and need to alloc a dma buffer
this mens i have to set the page entrees to NO_CACHE

so i thort of using get_vm_area to alloc some virt-space
then get some pages and setup a page table .
but it dose not work i an not access get_vm_area from
my module i get unresolved symbule .
this cmd can be very nice for doing your one maping
(maybe even you own page_faults)

will i thort of using ioremap the access get_vm_area
but i will not give me linear virt

so what can i do pleas help

thank you

David <sector2@ihug.co.nz>

I will have source with my chips thankyou!


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
