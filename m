Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262429AbVDGLWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262429AbVDGLWN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 07:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262431AbVDGLVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 07:21:54 -0400
Received: from cantor2.suse.de ([195.135.220.15]:35756 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262429AbVDGLVa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 07:21:30 -0400
Message-ID: <425517B3.2010702@suse.de>
Date: Thu, 07 Apr 2005 13:21:23 +0200
From: Hannes Reinecke <hare@suse.de>
Organization: SuSE Linux AG
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.5) Gecko/20050306
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] Use proper seq_file api for /proc/scsi/scsi
References: <42550173.1040503@suse.de> <20050407103123.GB9586@infradead.org>
In-Reply-To: <20050407103123.GB9586@infradead.org>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Thu, Apr 07, 2005 at 11:46:27AM +0200, Hannes Reinecke wrote:
>>Hi all,
>>
>>/proc/scsi/scsi currently has a very dumb implementation of the seq_file
>>api which causes 'cat /proc/scsi/scsi' to return with -ENOMEM when a
>>large amount of devices are connected.
> 
> /proc/scsi/scsi is deprecated and even only compiled in if
> "legacy /proc/scsi/ support" is enabled.  Please move over to lssci which
> is using sysfs ASAP.
> 
Ah. And that's enough reason for it not to work properly?
Deprecated as it may be, but one could at least expect it to _work_.

Puzzled.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke			hare@suse.de
SuSE Linux AG				S390 & zSeries
Maxfeldstraße 5				+49 911 74053 688
90409 Nürnberg				http://www.suse.de
