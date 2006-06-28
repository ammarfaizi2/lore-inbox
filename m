Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423276AbWF1LSo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423276AbWF1LSo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 07:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423278AbWF1LSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 07:18:44 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:8877 "EHLO
	mail-out.m-online.net") by vger.kernel.org with ESMTP
	id S1423276AbWF1LSn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 07:18:43 -0400
X-Auth-Info: 1977qM1NOk5+HstnD78Y72BZm3FDtcxRYQaIV/ccJXc=
Date: Wed, 28 Jun 2006 13:19:38 +0200
From: Christian Lohmaier <cloph@openoffice.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [Bugme-new] [Bug 6745] New: kernel hangs when trying to read    atip wiith cdrecord
Message-ID: <20060628111937.GA4126@bm617259.muenchen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44A22FC3.nail3NU1XXW6C@burner>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jun 2006 09:30:22 +0200, Joerg Schilling wrote:
> Christian Lohmaier wrote:
>>I updated the bug-report with some info I collected from another bug. 
>
>>Apparently my drive sends additional interrupts that confuses the kernel 
>>and make it hang. 
>>The problem is triggered with newer versions of cdrecord (cdrtools 
>>2.01a33 and newer) where cdrecord changed its driver interface. 
> 
> cdrtools-2.01a33 is extremely old (2 years).
> 
> It did not introduce new SCSI commands (compared to prevuious versions) and I
> would be interested why this problem is discussed late.

Because that problems only occurs in the combination of recent cdrtools with
kernel 2.6.x
I for myself have been using kernel 2.4.x until recently I switched to 2.6.x

> The only new thing with cdrecord-2.01a33 is that it started to transfer more 
> than 4 bytes with the "read buffer" command. As this is only issued in case that
> the "read buffer" command did succeed with 4 bytes transfer count and as 
> cdrecord does not transfer more than the drive advertizes, I am just depending 
> on a kernel that does not freeze from the SCSI command I am issuing.

OK - thats already a hint. Maybe this helps the kernel-devs.

ciao
Christian
-- 
NP: Papa Roach - Between Angels And Insects
