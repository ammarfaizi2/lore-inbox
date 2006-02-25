Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964842AbWBYBRF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964842AbWBYBRF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 20:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964838AbWBYBRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 20:17:04 -0500
Received: from mail.dvmed.net ([216.237.124.58]:64991 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964834AbWBYBRB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 20:17:01 -0500
Message-ID: <43FFB009.6070403@pobox.com>
Date: Fri, 24 Feb 2006 20:16:57 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Milan Kupcevic <milan@physics.harvard.edu>
CC: linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, trivial@rustcorp.com.au,
       torvalds@osdl.org
Subject: Re: [PATCH] sata_promise: Port enumeration order - SATA 150 TX4,
 SATA 300 TX4
References: <43FFAE3D.7010002@physics.harvard.edu>
In-Reply-To: <43FFAE3D.7010002@physics.harvard.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Milan Kupcevic wrote:
> From: Milan Kupcevic <milan@physics.harvard.edu>
> 
> Fix Promise SATAII 150 TX4 (PDC40518) and Promise SATA 300 TX4 
> (PDC40718-GP) wrong port enumeration order that makes it (nearly) 
> impossible to deal with boot problems using two or more drives.
> 
> Signed-off-by: Milan Kupcevic <milan@physics.harvard.edu>
> ---
> 
> The current kernel driver assumes:
> 
> port 1 - scsi3
> port 2 - scsi1
> port 3 - scsi0
> port 4 - scsi2

The current kernel driver assumes nothing, but simply exports what the 
hardware gives us.

It sounds like you are trying to patch the kernel because you received 
an incorrectly-wired board.  NAK.

	Jeff



