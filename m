Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266303AbUAHT6G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 14:58:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265944AbUAHTyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 14:54:43 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:61854 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S266342AbUAHTxw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 14:53:52 -0500
Date: Thu, 8 Jan 2004 11:57:32 -0800
From: Mike Anderson <andmike@us.ibm.com>
To: Christoph Hellwig <hch@infradead.org>,
       Andrew Vasquez <andrew.vasquez@qlogic.com>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux-SCSI <linux-scsi@vger.kernel.org>
Subject: Re: [ANNOUNCE] QLogic qla2xxx driver update available (v8.00.00b7).
Message-ID: <20040108195732.GB10391@beaverton.ibm.com>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Vasquez <andrew.vasquez@qlogic.com>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Linux-SCSI <linux-scsi@vger.kernel.org>
References: <B179AE41C1147041AA1121F44614F0B060EDD4@AVEXCH02.qlogic.org> <20040108165414.A12233@infradead.org> <20040108193336.GB10243@beaverton.ibm.com> <20040108193427.A14545@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040108193427.A14545@infradead.org>
X-Operating-System: Linux 2.0.32 on an i486
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig [hch@infradead.org] wrote:
> > Also some partial information of the other hba api
> > functions could be supported though other sysfs attributes but the sends
> > would still need to use the old interface.
> 
> With sends are you referring to function that support certain scsi
> commands like report luns and report capacity?  We have a perfectly
> fine interface for that and it's SG_IO.. 

I was thinking about the fabric management functions section of the
spec. I would believe that the SG_IO should be able to handle the SCSI
information functions section (though I have used this interface very
little).

-andmike
--
Michael Anderson
andmike@us.ibm.com

