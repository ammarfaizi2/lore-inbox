Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130508AbRAXOoJ>; Wed, 24 Jan 2001 09:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130382AbRAXOn6>; Wed, 24 Jan 2001 09:43:58 -0500
Received: from sls.lcs.mit.edu ([18.27.0.167]:34812 "EHLO sls.lcs.mit.edu")
	by vger.kernel.org with ESMTP id <S131028AbRAXOnu>;
	Wed, 24 Jan 2001 09:43:50 -0500
Message-ID: <3A6EEA1B.87732D70@sls.lcs.mit.edu>
Date: Wed, 24 Jan 2001 09:43:39 -0500
From: I Lee Hetherington <ilh@sls.lcs.mit.edu>
Organization: MIT Laboratory for Computer Science
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.2.18-4.smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Matt_Domsch@Dell.com
CC: linux-kernel@vger.kernel.org
Subject: Re: No SCSI Ultra 160 with Adaptec Controller
In-Reply-To: <CDF99E351003D311A8B0009027457F1403BF9C0C@ausxmrr501.us.dell.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt_Domsch@Dell.com wrote:

> Something to note, however: the media transfer rate for those disks is at
> most ~20MB/sec.

Hmm...

     scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI)
     5.1.31/3.2.4
            <Adaptec AIC-7899 Ultra 160/m SCSI host adapter>
     Vendor: QUANTUM   Model: ATLAS10K2-TY092L  Rev: DA40
       Type:   Direct-Access                      ANSI SCSI revision: 03

     /dev/sda:
      Timing buffered disk reads:  64 MB in  1.59 seconds =40.25 MB/sec

They can do more like 40MB/s, so only two disks could saturate the 80MB/s.

This is in a Dell Precision 620.

--Lee Hethernigton


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
