Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261564AbUL3H5C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261564AbUL3H5C (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 02:57:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbUL3H5C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 02:57:02 -0500
Received: from [81.23.229.73] ([81.23.229.73]:11670 "EHLO mail.eduonline.nl")
	by vger.kernel.org with ESMTP id S261564AbUL3H47 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 02:56:59 -0500
From: Norbert van Nobelen <norbert-kernel@edusupport.nl>
Organization: EduSupport BV
To: Micha <micha-1@fantasymail.de>
Subject: Re: ide problem...
Date: Thu, 30 Dec 2004 08:56:52 +0100
User-Agent: KMail/1.6.2
References: <200412292213.34517.micha-1@fantasymail.de>
In-Reply-To: <200412292213.34517.micha-1@fantasymail.de>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200412300856.52877.norbert-kernel@edusupport.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ide-scsi is a bit of misleading name.
In the beginning there were only SCSI cdrom drives and proprietary cdrom 
drives.
At a certain moment the IDE cdrom drive entered the arena with the ATAPI 
interface (and still some proprietary interfaces).
The scsi drivers were written already to support cdrom devices, and they still 
contain the code to control the device correctly.

On Wednesday 29 December 2004 22:13, you wrote:
> I got an error reading a dvd with 2.6.9 and ide interface. Switching to
> ide-scsi for the dvd-rom made the dvd work. Is this an ide-error? I think
> libdvdread should not know wether it's reading a scsi or a ide device...
>
>  Michael
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
