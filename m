Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265614AbRFWD6Z>; Fri, 22 Jun 2001 23:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265510AbRFWD6Q>; Fri, 22 Jun 2001 23:58:16 -0400
Received: from james.kalifornia.com ([208.179.59.2]:29788 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S265434AbRFWD55>; Fri, 22 Jun 2001 23:57:57 -0400
Message-ID: <3B3413B1.6040808@blue-labs.org>
Date: Fri, 22 Jun 2001 20:57:37 -0700
From: David Ford <david@blue-labs.org>
Organization: Blue Labs
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.1+) Gecko/20010622
X-Accept-Language: en-us
MIME-Version: 1.0
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Cleanup kbuild for aic7xxx
In-Reply-To: <200106230307.f5N370U83109@aslan.scsiguy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>I don't usually keep up with the various "pre" or "ac" kernels, so I
>can't give you pointers about which ones are more stable, etc.  As
>far as the aic7xxx driver is concerned, they should all work the same.
>I primarally provide patches for release kernels, so that may limit
>what kernels you can use to get up to the latest aic7xxx driver.
>

Ok, here's the relevant output from 2.2.19.  In future emails, would 
like all the information posted to the list or would you like URLs to 
the text docs?

Linux version 2.2.19 (root@James) (gcc version 2.95.3 20010315 
(release)) #1 Fri
 Jun 22 20:17:08 PDT 2001
...
(scsi0) <Adaptec AIC-7896/7 Ultra2 SCSI host adapter> found at PCI 0/12/1
(scsi0) Wide Channel B, SCSI ID=7, 32/255 SCBs
(scsi0) Downloading sequencer code... 393 instructions downloaded
(scsi1) <Adaptec AIC-7896/7 Ultra2 SCSI host adapter> found at PCI 0/12/0
(scsi1) Wide Channel A, SCSI ID=7, 32/255 SCBs
(scsi1) Downloading sequencer code... 393 instructions downloaded
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.1.33/3.2.4
       <Adaptec AIC-7896/7 Ultra2 SCSI host adapter>
scsi1 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.1.33/3.2.4
       <Adaptec AIC-7896/7 Ultra2 SCSI host adapter>
scsi : 2 hosts.
  Vendor: SEAGATE   Model: ST318436LW        Rev: 0005
  Type:   Direct-Access                      ANSI SCSI revision: 03
Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
(scsi0:0:0:2) Synchronous at 40.0 Mbyte/sec, offset 31.
scsi : detected 1 SCSI generic 1 SCSI disk total.
SCSI device sda: hdwr sector= 512 bytes. Sectors= 35885168 [17522 MB] 
[17.5 GB]


David


