Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261306AbUJ3Xl3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261306AbUJ3Xl3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 19:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261415AbUJ3Xl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 19:41:29 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:65211 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261306AbUJ3XlX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 19:41:23 -0400
Message-ID: <41842695.8080203@pobox.com>
Date: Sat, 30 Oct 2004 19:41:09 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthijs Melchior <mmelchior@xs4all.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.10-rc1] ahci: Intel ICH6R (925X) corrections
References: <417A7E0D.6060704@xs4all.nl> <418423C8.309@xs4all.nl>
In-Reply-To: <418423C8.309@xs4all.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthijs Melchior wrote:
> This patch makes the following changes to drivers/scsi/ahci.c
> 
> - Add definition for SActive register
> - Add most interrupt sources to default interrupt mask
> - Write low 32 bits of FIS address to PxFB, where they belong
> - Set command active bit in PxSACT before setting command issue bit in PxCI
> - Announce Sub Class Code in driver info message [IDE, SATA or RAID]


heh, cool...  you found the stupid AHCI bug that I have been searching 
for for over a week :)

Patch looks good, will test...

	Jeff


