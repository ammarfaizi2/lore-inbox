Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275614AbTHOAWj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 20:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275615AbTHOAWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 20:22:39 -0400
Received: from mail.kroah.org ([65.200.24.183]:31965 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S275614AbTHOAWh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 20:22:37 -0400
Date: Thu, 14 Aug 2003 17:15:52 -0700
From: Greg KH <greg@kroah.com>
To: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: finding which pci device works as ide controller for root fs
Message-ID: <20030815001552.GA4776@kroah.com>
References: <200308141826.30735.arekm@pld-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308141826.30735.arekm@pld-linux.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 14, 2003 at 06:26:30PM +0200, Arkadiusz Miskiewicz wrote:
> 
> [arekm@mobarm arekm]$ ls -l /sys/block/hda/device
> lrwxrwxrwx    1 root     root           46 2003-08-14 00:49 
> /sys/block/hda/device -> ../../devices/pci0000:00/0000:00:11.1/ide0/0.0
> 
> Is it possible to get PCI ID from sysfs for specified device?

It's right there in the path to the ide device "0000:00:11.1"


greg k-h
