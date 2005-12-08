Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751185AbVLHNcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbVLHNcE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 08:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbVLHNcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 08:32:04 -0500
Received: from mail0.lsil.com ([147.145.40.20]:55253 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S1751135AbVLHNcD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 08:32:03 -0500
Message-ID: <0E3FA95632D6D047BA649F95DAB60E5703662C86@exa-atlanta>
From: "Ju, Seokmann" <Seokmann.Ju@engenio.com>
To: "'Mark Lord'" <lkml@rtr.ca>, Linux Kernel <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org
Subject: RE: [PATCH] Fix incorrect pointer in megaraid.c MODE_SENSE emulat
	ion
Date: Thu, 8 Dec 2005 08:31:50 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2658.27)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
> The SCSI megaraid drive goes to great effort to kmap
> the scatterlist buffer (if used), but then uses the
> wrong pointer when copying to it afterward.
Thank you for submitting a patch that fixes a real problem.
The patch looks perfect!

Regards,

> -----Original Message-----
> From: Mark Lord [mailto:lkml@rtr.ca] 
> Sent: Wednesday, December 07, 2005 5:47 PM
> To: Linux Kernel; linux-scsi@vger.kernel.org
> Subject: [PATCH] Fix incorrect pointer in megaraid.c 
> MODE_SENSE emulation
> 
> The SCSI megaraid drive goes to great effort to kmap
> the scatterlist buffer (if used), but then uses the
> wrong pointer when copying to it afterward.
> 
> Signed-off-by:  Mark Lord <lkml@rtr.ca>
> 
