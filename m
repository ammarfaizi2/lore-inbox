Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161502AbWJVDCw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161502AbWJVDCw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 23:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161510AbWJVDCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 23:02:52 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:35301 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1161502AbWJVDCv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 23:02:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=dyhdZYpjTwc+HzCrsrMHXCLS1J1H4fWNf/7behy1HmUn4Cz3MetLFaaXnXsuKlAhZpRNmxPcblmDlFllETQUmPWA6wdJ4qzAAb+AJ4JUo2/MPzBIbuQnwyLWtVrwVfbJRULRSgai0OEucHSXLPXC9mji7WhQPJfCITkGnQrg8fk=
Message-ID: <453ADF02.40300@gmail.com>
Date: Sat, 21 Oct 2006 21:01:22 -0600
From: "Berck E. Nash" <flyboy@gmail.com>
User-Agent: Icedove 1.5.0.7 (X11/20061014)
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc2-mm2 AHCI lengthy pause on detection
References: <453663DB.5060908@gmail.com> <45383F6F.6090102@gmail.com>
In-Reply-To: <45383F6F.6090102@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> Can you try the attached patch?  And please post the result of hdparm -I 
> /dev/sdX.

No difference with that patch.

/dev/sde:

ATA device, with non-removable media
         Model Number:       ST3250823AS
         Serial Number:      5ND0HPTV
         Firmware Revision:  3.03
Standards:
         Supported: 7 6 5 4
         Likely used: 7
Configuration:
         Logical         max     current
         cylinders       16383   16383
         heads           16      16
         sectors/track   63      63
         --
         CHS current addressable sectors:   16514064
         LBA    user addressable sectors:  268435455
         LBA48  user addressable sectors:  488397168
         device size with M = 1024*1024:      238475 MBytes
         device size with M = 1000*1000:      250059 MBytes (250 GB)
Capabilities:
         LBA, IORDY(can be disabled)
         Queue depth: 32
         Standby timer values: spec'd by Standard, no device specific 
minimum
         R/W multiple sector transfer: Max = 16  Current = 16
         Recommended acoustic management value: 128, current value: 0
         DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6
              Cycle time: min=120ns recommended=120ns
         PIO: pio0 pio1 pio2 pio3 pio4
              Cycle time: no flow control=240ns  IORDY flow control=120ns
Commands/features:
         Enabled Supported:
            *    SMART feature set
                 Security Mode feature set
            *    Power Management feature set
            *    Write cache
            *    Look-ahead
            *    Host Protected Area feature set
            *    WRITE_BUFFER command
            *    READ_BUFFER command
            *    DOWNLOAD_MICROCODE
                 SET_MAX security extension
            *    48-bit Address feature set
            *    Device Configuration Overlay feature set
            *    Mandatory FLUSH_CACHE
            *    FLUSH_CACHE_EXT
            *    SMART error logging
            *    SMART self-test
            *    General Purpose Logging feature set
            *    SATA-I signaling speed (1.5Gb/s)
            *    Native Command Queueing (NCQ)
            *    Phy event counters
            *    Software settings preservation
Security:
         Master password revision code = 65534
                 supported
         not     enabled
         not     locked
                 frozen
         not     expired: security count
         not     supported: enhanced erase
Checksum: correct
