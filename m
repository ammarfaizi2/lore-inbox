Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261461AbVCYHDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261461AbVCYHDv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 02:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbVCYHDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 02:03:50 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:48252 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261461AbVCYHDt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 02:03:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding;
        b=C0ZVNdlfrAuIKfyDQJN5GBC9jSD8OpMY5zH7MwNOaPIGdqTxn695AQqhAeiBK0cH4G/1lWwPDvAypaG2mXfCF/hULDoHV1Qy33owlmKNog6cX82zkPcaHvbKMHIZ44/M5kCn7pzw+sugGn+SfV7YbT7BFi9EAoS4oy/vcJo4CQU=
Message-ID: <aa3a704505032423037a52ce53@mail.gmail.com>
Date: Fri, 25 Mar 2005 04:03:48 -0300
From: =?ISO-8859-1?Q?S=F8ren_Lott?= <soren3@gmail.com>
Reply-To: =?ISO-8859-1?Q?S=F8ren_Lott?= <soren3@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: 
Cc: jgarzik@pobox.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

in the SATA kconfig menu, the help message from  
Intel PIIX/ICH SATA support says:

 CONFIG_SCSI_ATA_PIIX:

This option enables support for ICH5 Serial ATA.
 If PATA support was enabled previously, this enables
 support for select Intel PIIX/ICH PATA host controllers.

anyone care to clarify if this mean that having enabled:

CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

i can use the PATA ports on a ICH5 controller through libata ?
if not, which is exactly the meaning of "If PATA support was enabled
previously" on this message ?

thanks.

-SL.
