Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265586AbTF3Rqk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 13:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265564AbTF3Rqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 13:46:40 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18061 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265667AbTF3Rqi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 13:46:38 -0400
Message-ID: <3F007AC4.9040304@pobox.com>
Date: Mon, 30 Jun 2003 14:00:36 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Mock <jeff-ml@mock.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.4.21 ICH5 SATA related hang during boot
References: <5.1.0.14.2.20030630101734.03daddc0@mail.mock.com>
In-Reply-To: <5.1.0.14.2.20030630101734.03daddc0@mail.mock.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Mock wrote:
> 
> I tried 2.4.21-ac4 to see if there were any ICH5-SATA related
> changes.  2.4.21-ac4 does not seem to find the ICH5-SATA controller
> or probe the SATA drives, (problems with ICH5-SATA on 2.4.21 are
> described below).
> 
> Does anyone know what's up with SATA support on ICH5?


Enable CONFIG_SCSI_ATA and CONFIG_SCSI_ATA_PIIX...

	Jeff



