Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932099AbWBJOQX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbWBJOQX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 09:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932100AbWBJOQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 09:16:23 -0500
Received: from mail.astral.ro ([193.230.240.11]:47779 "EHLO mail.astral.ro")
	by vger.kernel.org with ESMTP id S932099AbWBJOQX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 09:16:23 -0500
Message-ID: <43ECA035.5040302@astral.ro>
Date: Fri, 10 Feb 2006 16:16:21 +0200
From: Imre Gergely <imre.gergely@astral.ro>
Organization: Astral Telecom SA
User-Agent: Thunderbird 1.5 (X11/20051025)
MIME-Version: 1.0
To: Erik Mouw <erik@harddisk-recovery.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: disabling libata
References: <43EC97C6.10607@astral.ro> <20060210141130.GE28676@harddisk-recovery.com>
In-Reply-To: <20060210141130.GE28676@harddisk-recovery.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Erik Mouw wrote:
> On Fri, Feb 10, 2006 at 03:40:22PM +0200, Imre Gergely wrote:
>> i have a SATA hardisk, and am using FC4 with default kernel
>> (2.6.14-1.1644_FC4). i was wondering if it's possible to tell the kernel to use
>> the old ATA driver with SATA support instead of libata, for my harddisk to
>> appear as hdX, and not sdX.
> 
> Why would you want to do that? SATA are driven by libata and the disks
> turn up as SCSI devices. There's no way around that (yet).
> 

if i recompile the kernel, and leave out the libata part, and compile in
support for SATA, under ATA, the harddisks turn up as normal IDE devices (ie
hde, hdf, etc). i would like that without recompiling. if it's possible of course.

