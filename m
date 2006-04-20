Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750966AbWDTPK6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966AbWDTPK6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 11:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750979AbWDTPK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 11:10:58 -0400
Received: from iona.labri.fr ([147.210.8.143]:45980 "EHLO iona.labri.fr")
	by vger.kernel.org with ESMTP id S1750966AbWDTPK5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 11:10:57 -0400
Message-ID: <4447A3B0.8030403@labri.fr>
Date: Thu, 20 Apr 2006 17:07:28 +0200
From: Emmanuel Fleury <emmanuel.fleury@labri.fr>
User-Agent: Mail/News 1.5 (X11/20060228)
MIME-Version: 1.0
To: Emmanuel Fleury <emmanuel.fleury@labri.fr>
CC: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org,
       GarnierB-02@mail.europcar.com
Subject: Re: [libata] atapi_enabled problem
References: <44477D93.50501@labri.fr> <44479E8B.8010003@labri.fr>
In-Reply-To: <44479E8B.8010003@labri.fr>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Emmanuel Fleury wrote:
> 
> Indeed, I tried out several possibilities and it appeared that the way
> to generate such errors was to set the Intel PIIX/ICH SATA support as
> built-in (y). When set as module (m), everything is fine.
> 
> Device Drivers --->
>   SCSI device support --->
>     SCSI low-level drivers --->
>       Intel PIIX/ICH SATA support

Problem does also appear when AHCI SATA support is built-in (and Intel
PIIX/ICH SATA support is left as module).

-- 
Emmanuel Fleury
