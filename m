Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132688AbRDXCCs>; Mon, 23 Apr 2001 22:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132690AbRDXCCj>; Mon, 23 Apr 2001 22:02:39 -0400
Received: from ausxc10.us.dell.com ([143.166.98.229]:17677 "EHLO
	ausxc10.us.dell.com") by vger.kernel.org with ESMTP
	id <S132688AbRDXCC0>; Mon, 23 Apr 2001 22:02:26 -0400
Message-ID: <CDF99E351003D311A8B0009027457F140810E26A@ausxmrr501.us.dell.com>
From: Matt_Domsch@Dell.com
To: jgarzik@mandrakesoft.com
Cc: linux-kernel@vger.kernel.org
Subject: RE: [RFC][PATCH] adding PCI bus information to SCSI layer
Date: Mon, 23 Apr 2001 20:58:29 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> PCI ids can be derived from bus/slot/function.

Even better.  I'll remove the extraneous fields then, and only return those.

typedef struct scsi_pci {
        unsigned char   bus_number;
        unsigned int    devfn;          /* encoded device & function index
*/
} Scsi_Pci;

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer
Dell Linux Systems Group
Linux OS Development
www.dell.com/linux


