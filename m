Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132682AbQKWICe>; Thu, 23 Nov 2000 03:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132688AbQKWICX>; Thu, 23 Nov 2000 03:02:23 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:15 "HELO mail.ocs.com.au")
        by vger.kernel.org with SMTP id <S132682AbQKWICM>;
        Thu, 23 Nov 2000 03:02:12 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
Subject: Re: Patch(?): pci_device_id tables for drivers/scsi in 2.4.0-test11 
In-Reply-To: Your message of "Thu, 23 Nov 2000 02:25:33 CDT."
             <3A1CC66D.BC1EB6DB@mandrakesoft.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 23 Nov 2000 18:31:56 +1100
Message-ID: <1370.974964716@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2000 02:25:33 -0500, 
Jeff Garzik <jgarzik@mandrakesoft.com> wrote:
>Keith Owens wrote:
>> #define PCITBL(v,d,sv,sd) \
>>  { PCI_VENDOR_ID_##v, PCI_DEVICE_ID_##d, \
>>    PCI_VENDOR_ID_##sv, PCI_DEVICE_ID_##sd }
>
>* your macro fails for the 'ANY' case, because the proper macro is
>PCI_ANY_ID not PCI_{VENDOR,DEVICE}_ID_ANY.

It was just a suggestion.  Actually getting it working was left as an
exercise for the reader ;).

#define PCI_VENDOR_ID_ANY PCI_ANY_ID
#define PCI_DEVICE_ID_ANY PCI_ANY_ID

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
