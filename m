Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263460AbTL2APM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 19:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263468AbTL2APM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 19:15:12 -0500
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:60387 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S263460AbTL2API
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 19:15:08 -0500
Message-ID: <3FEF721D.7020405@rackable.com>
Date: Sun, 28 Dec 2003 16:15:25 -0800
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Leon Toh <tltoh@attglobal.net>
CC: Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Adaptec/DPT I2O Option Omitted From Linux 2.6.0 Kernel  Configuration
 Tool
References: <6.0.1.1.2.20031227093632.0229afe8@wheresmymailserver.com>
In-Reply-To: <6.0.1.1.2.20031227093632.0229afe8@wheresmymailserver.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Dec 2003 00:15:06.0552 (UTC) FILETIME=[D00D9B80:01C3CDA0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Leon Toh wrote:

> Merry Christmas Everyone,
> 
> I just downloaded full source code of linux-2.6.0 to start doing some 
> work and testing of  Adaptec/DPT I2O controller's. This is when I happen 
> to notice Adapec/DPT I2O option have been omitted from Linux Kernel 
> 2.6.0 Configuration tool.
> 
> Typically this option is located in *Device Drivers -> SCSI device 
> support -> SCSI low-level drivers*. Furthermore it is also not listed in 
> *Device Drivers -> I2O device support* also. And the driver source 
> (dpti2o) is residing in /drivers/scsi.
> 
> Please advice how should I than go about in hacking Linux 2.6.0 Kernel 
> Configuration tool to include Adaptec/DPT I2O support ?
> 
> Also any reason for the Adaptec/DPT I2O option being omitted out from 
> Linux Kernel configuration tool  ? Or is it just happen to be accidental 
> ? Will this be option made available in the next release or pre-release 
> of 2.6 kernel than ?
> 

   The DPT I2O driver was never converted to the new driver model.  The 
driver from what I can see is a mess.  It doesn't even compile in 2.4 
for a number of archs like amd64.

   A while back  a bunch of people (including myself) raised the concern 
through various channels with adaptec.  In theroy someone at adaptec is 
working on it, but there was not an ETA.


