Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261715AbVCGIoU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261715AbVCGIoU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 03:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261709AbVCGIoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 03:44:19 -0500
Received: from mx2.mail.ru ([194.67.23.122]:7192 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S261706AbVCGIn4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 03:43:56 -0500
From: Alexey Dobriyan <adobriyan@mail.ru>
To: Alex Aizman <itn780@yahoo.com>
Subject: Re: [ANNOUNCE 3/6] Open-iSCSI High-Performance Initiator for Linux
Date: Mon, 7 Mar 2005 11:44:18 +0200
User-Agent: KMail/1.6.2
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <422BFF88.50205@yahoo.com>
In-Reply-To: <422BFF88.50205@yahoo.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200503071144.19133.adobriyan@mail.ru>
X-Spam: Not detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 March 2005 09:15, Alex Aizman wrote:
>           drivers/scsi/Kconfig changes.

> --- linux-2.6.11.orig/drivers/scsi/Kconfig
> +++ linux-2.6.11.dima/drivers/scsi/Kconfig

> +config ISCSI_IF
> +	tristate "iSCSI Open Transport Interface"
> +	depends on SCSI && INET
> +	---help---
> +	To compile this driver as a module, choose M here: the
> +	module will be called iscsi_if.
> +
> +	This driver manages multiple iSCSI transports. This module is required
> +	for normal iscsid operation.
> +
> +	See more detailed information here:
> +
> + 	http://www.open-iscsi.org

"To compile this driver as a module ..." boilerplate usually goes at the end
of description. Help text is indented with 2 spaces wrt "---help---":

	---help---
	  This driver manages multiple iSCSI transports. ...

	Alexey
