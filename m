Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261592AbTKHAYq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 19:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbTKGWG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:06:58 -0500
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:47633 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263981AbTKGJd7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 04:33:59 -0500
Date: Fri, 7 Nov 2003 09:33:58 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Vasquez <andrew.vasquez@qlogic.com>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>,
       Linux-SCSI <linux-scsi@vger.kernel.org>
Subject: Re: [ANNOUNCE] QLogic qla2xxx driver update available (v8.00.00b6).
Message-ID: <20031107093358.A1992@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Vasquez <andrew.vasquez@qlogic.com>,
	Linux-Kernel <linux-kernel@vger.kernel.org>,
	Linux-SCSI <linux-scsi@vger.kernel.org>
References: <B179AE41C1147041AA1121F44614F0B060ED69@AVEXCH02.qlogic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <B179AE41C1147041AA1121F44614F0B060ED69@AVEXCH02.qlogic.org>; from andrew.vasquez@qlogic.com on Thu, Nov 06, 2003 at 09:02:28AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	o Failover -- DM and the fastfail infrastructure appear to be
> 	  in the early stages of adoption (implementation?).  There's
> 	  no question that QLogic will support the interfaces once
> 	  they mature.  Let's just agree to disagree...

Hey, there's no one saying you have to kill all your failover stuff.  Just
make it clearly optional and don't include it if_/when you submit the driver
for inclusion.  We just can't have a failover implementation for each vendor.
Not to mention that the LLDD really is the wrong place for it..

