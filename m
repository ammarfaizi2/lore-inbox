Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261711AbVGUJQD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbVGUJQD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 05:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261716AbVGUJQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 05:16:03 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:62337 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261711AbVGUJQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 05:16:01 -0400
Message-ID: <42DF67BF.2070105@gmail.com>
Date: Thu, 21 Jul 2005 11:15:43 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Bob Tracy <rct@gherkin.frus.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Obsolete files in 2.6 tree
References: <20050721024421.D4857DBA1@gherkin.frus.com>
In-Reply-To: <20050721024421.D4857DBA1@gherkin.frus.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bob Tracy napsal(a):

>Jiri Slaby wrote:
>  
>
>>Are these files obsolete and could be deleted from tree.
>>Does anybody use them? Could anybody compile them?
>>
>>(...)
>>drivers/scsi/NCR5380.c
>>drivers/scsi/NCR5380.h
>>(...)
>>    
>>
>
>The above are used by (at least) the PAS16 SCSI driver.  The PAS16 is
>a 16-bit ISA soundcard that, in its "studio" incarnation, has a slow-
>speed (intended for the CD-ROM drives of the time) SCSI interface based
>on the NCR 5380.  As I recall, the Linux driver operated in polled mode
>only: no interrupt handling capability.  That deficiency was never
>corrected while I was a user of that card, and I quit using the card
>somewhere in the 2.2 kernel version timeframe.
>  
>
I think, that this driver uses g_NCR5380.c and g_NCR5380.h, doesn't it?

-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
241B347EC88228DE51EE A49C4A73A25004CB2A10

