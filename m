Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967828AbWLDXoj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967828AbWLDXoj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 18:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967853AbWLDXoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 18:44:39 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:39578 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967828AbWLDXoi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 18:44:38 -0500
Message-ID: <4574B2E4.8060206@garzik.org>
Date: Mon, 04 Dec 2006 18:44:36 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Bernard Pidoux <pidoux@ccr.jussieu.fr>
CC: linux-kernel@vger.kernel.org
Subject: Re: Why SCSI module needed for PCI-IDE ATA only disks ?
References: <457492B2.2050107@ccr.jussieu.fr>
In-Reply-To: <457492B2.2050107@ccr.jussieu.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernard Pidoux wrote:
> I am asking why need to compile the following modules while I do not
> have any SCSI device ?

libata uses SCSI to provide a lot of infrastructure that it would 
otherwise have to recreate.  Also, using SCSI meant that it 
automatically worked in existing installers.

	Jeff



