Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262087AbVBASR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262087AbVBASR5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 13:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262098AbVBASQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 13:16:13 -0500
Received: from linux.us.dell.com ([143.166.224.162]:40322 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S262097AbVBASPB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 13:15:01 -0500
Date: Tue, 1 Feb 2005 12:14:54 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: "Ju, Seokmann" <sju@lsil.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "Bagalkote, Sreenivas" <sreenib@lsil.com>,
       "Mukker, Atul" <Atulm@lsil.com>
Subject: Re: [Announce] megaraid_mbox 2.20.4.3 patch
Message-ID: <20050201181454.GA13076@lists.us.dell.com>
References: <0E3FA95632D6D047BA649F95DAB60E570366262C@exa-atlanta>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E570366262C@exa-atlanta>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2005 at 07:52:42PM -0500, Ju, Seokmann wrote:
> Hello,
> 
> Here is a patch for megaraid_mbox 2.20.4.3 and megaraid_mm 2.20.2.5.
> The patch includes following changes/fixes
> - sysfs support for drive addition/removal
> - Tape drive timeout issue
> - Made some code static
> 
> I am attaching and inlining the patch.

This patch is mangled.  Long lines are wrapped, and appears to be in
ISO-8859-1, such that spaces (ascii 0x20) appear as hex 0xa0.  This
makes it difficult to review, and impossible to apply.

+// definitions for the device attributes for exporting logical drive number
+// for a scsi address (Host, Channel, Id, Lun)
+
+CLASS_DEVICE_ATTR(megaraid_mbox_app_hndl, S_IRUSR, megaraid_sysfs_show_app_hndl,
+           NULL);

How is this being used by your apps please?


Otherwise the patch looks sane.

Thanks,
Matt



-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
