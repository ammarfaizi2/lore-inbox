Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266255AbUAHThT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 14:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266236AbUAHTeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 14:34:44 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:20241 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266226AbUAHTee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 14:34:34 -0500
Date: Thu, 8 Jan 2004 19:34:27 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Vasquez <andrew.vasquez@qlogic.com>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux-SCSI <linux-scsi@vger.kernel.org>
Subject: Re: [ANNOUNCE] QLogic qla2xxx driver update available (v8.00.00b7).
Message-ID: <20040108193427.A14545@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Vasquez <andrew.vasquez@qlogic.com>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Linux-SCSI <linux-scsi@vger.kernel.org>
References: <B179AE41C1147041AA1121F44614F0B060EDD4@AVEXCH02.qlogic.org> <20040108165414.A12233@infradead.org> <20040108193336.GB10243@beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040108193336.GB10243@beaverton.ibm.com>; from andmike@us.ibm.com on Thu, Jan 08, 2004 at 11:33:36AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 08, 2004 at 11:33:36AM -0800, Mike Anderson wrote:
> This sounds good. It would seem that HBA API adapter and port
> information through sysfs (libsysfs) should be doable through the
> transport class.

Yes.

> Also some partial information of the other hba api
> functions could be supported though other sysfs attributes but the sends
> would still need to use the old interface.

With sends are you referring to function that support certain scsi
commands like report luns and report capacity?  We have a perfectly
fine interface for that and it's SG_IO.. 
