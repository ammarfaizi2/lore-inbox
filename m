Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264119AbTKGWC0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 17:02:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264294AbTKGWAA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:00:00 -0500
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:49169 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263988AbTKGJjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 04:39:02 -0500
Date: Fri, 7 Nov 2003 09:39:00 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Vasquez <andrew.vasquez@qlogic.com>
Cc: arjanv@redhat.com, Linux-Kernel <linux-kernel@vger.kernel.org>,
       Linux-SCSI <linux-scsi@vger.kernel.org>
Subject: Re: [ANNOUNCE] QLogic qla2xxx driver update available (v8.00.00b6).
Message-ID: <20031107093900.C1992@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Vasquez <andrew.vasquez@qlogic.com>, arjanv@redhat.com,
	Linux-Kernel <linux-kernel@vger.kernel.org>,
	Linux-SCSI <linux-scsi@vger.kernel.org>
References: <B179AE41C1147041AA1121F44614F0B0598CEA@AVEXCH02.qlogic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <B179AE41C1147041AA1121F44614F0B0598CEA@AVEXCH02.qlogic.org>; from andrew.vasquez@qlogic.com on Thu, Nov 06, 2003 at 11:33:28AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 06, 2003 at 11:33:28AM -0800, Andrew Vasquez wrote:
> I'm not entirely clear on what you are alluding to here, are you
> referring to SCSI_IOCTL_SEND_COMMAND?  There's significantly more
> functionality embedded within the IOCTLs than simply sending passthrus
> to devices.  Also, all of QLogic's drivers (linux, solaris, windows)
> implement to this 'external ioctl' spec, making changes to Linux alone
> would difficult.

I thought you had a hba lib to abstract the difference away?  Once again
the proper solution would be to just exclude all the ioctl mess for a
kernel build, if your HSV IHV and other three letter acronym partners
need the broken API they can patch it in again.

