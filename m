Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265140AbUEMV01@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265140AbUEMV01 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 17:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265100AbUEMV00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 17:26:26 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:6410 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265140AbUEMV0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 17:26:19 -0400
Date: Thu, 13 May 2004 22:26:18 +0100
From: Christoph Hellwig <hch@infradead.org>
To: David.Egolf@Bull.com
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [(re)Announce] Emulex LightPulse Device Driver
Message-ID: <20040513222618.A16617@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David.Egolf@Bull.com, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
References: <OF43CA8574.3A9C651D-ON07256E93.00714C91-07256E93.0075513F@az05.bull.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <OF43CA8574.3A9C651D-ON07256E93.00714C91-07256E93.0075513F@az05.bull.com>; from David.Egolf@Bull.com on Thu, May 13, 2004 at 02:21:24PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2004 at 02:21:24PM -0700, David.Egolf@Bull.com wrote:
> The first bullet on your post is of interest to us.  We currently support 
> customers with Emulex fc cards using a 2.4 kernel on IA64.  Our software 
> employs the hba api supplied from Emulex in order determine the 
> configuration of the SAN(s) connected to the cards.
> 
> Your comment is on the terse side.  Is your comment directed at this 
> particular implementation of the hba api code, the current packaging 
> situation, or do you have a general disregard for the hba api strategy? In 
> short, do you believe that the hba api can and/or should be supported for 
> the Emulex LightPulse Device Driver? 

The SNIA HBA API is horrible interface, and we won't support it as a mean
to interact with the kernel.  We're looking into a common API for quering
attributes of FC HBAs using sysfs and the fc transport class.

If someone wants to build a HBA API library ontop of that - we'll not my
business.

