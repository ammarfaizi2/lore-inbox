Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264154AbUFBVCH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264154AbUFBVCH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 17:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264153AbUFBVBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 17:01:36 -0400
Received: from Mail.MNSU.EDU ([134.29.1.12]:18368 "EHLO mail.mnsu.edu")
	by vger.kernel.org with ESMTP id S264138AbUFBVAu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 17:00:50 -0400
Message-ID: <40BE4002.5010905@mnsu.edu>
Date: Wed, 02 Jun 2004 16:00:50 -0500
From: "Jeffrey E. Hundstad" <jeffrey.hundstad@mnsu.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040514
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: aacraid hangs at boot on linux-2.4.27-pre1 20 second delay at
 lilo prompt makes it succeed
References: <40BD03C8.5060504@mnsu.edu>
In-Reply-To: <40BD03C8.5060504@mnsu.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My previous information was a bit in error.  I incorrectly remembered 
where the system would hang.  It hangs in the place indicated below:

SCSI subsystem driver Revision: 1.00
Red Hat/Adaptec aacraid driver (1.1-3 Apr 22 2004 14:34:42)
AAC0: kernel 2.8.4 build 6089
AAC0: monitor 2.8.4 build 6089
AAC0: bios 2.8.0 build 6089
AAC0: serial 635081d3fafaf001
scsi0 : percraid
------ THE SYSTEM HANGS HERE ------
  Vendor: DELL      Model:                   Rev: V1.0
  Type:   Direct-Access                      ANSI SCSI revision: 02


Jeffrey E. Hundstad wrote:

> While booting linux-2.4.27-pre1 the system hangs.  If I put a 20 
> second delay in at the lilo prompt then the system always boot 
> successfully.  ...I just pulled 20 seconds out of the air... less time 
> might work,  but I haven't tried.  I've also tried linux-2.4.24 with 
> the same results.
>
> I've since updated the system and raid card to the most current bios. 
> and it hasn't helped.  The old raid bios was build 6082.
>
> The system hangs right before the "Red Hat/Apaptec..." line below.
>
> dmesg:
> Red Hat/Adaptec aacraid driver (1.1-3 Apr 22 2004 14:34:42)
> AAC0: kernel 2.8.4 build 6089
> AAC0: monitor 2.8.4 build 6089
> AAC0: bios 2.8.0 build 6089
> AAC0: serial 635081d3fafaf001
> scsi0 : percraid
>  Vendor: DELL      Model:                   Rev: V1.0
>  Type:   Direct-Access                      ANSI SCSI revision: 02
> megaraid: v1.18k (Release Date: Thu Aug 28 10:05:11 EDT 2003)
> megaraid: no BIOS enabled.
>
> /proc/version:
> Linux version 2.4.27-pre1 (ricardo@krypton) (gcc version 2.95.4 
> 20011002 (Debian prerelease)) #1 SMP Thu Apr 22 14:33:58 CDT 2004
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

