Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262872AbTHQJjT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 05:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263861AbTHQJjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 05:39:19 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:54545 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262872AbTHQJjS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 05:39:18 -0400
Date: Sun, 17 Aug 2003 10:39:14 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Olaf Hering <olh@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Paul Mackeras <paulus@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: scsi proc_info called unconditionally
Message-ID: <20030817103914.A26579@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Olaf Hering <olh@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Paul Mackeras <paulus@samba.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030816084409.GA8038@suse.de> <1061053254.10688.6.camel@dhcp23.swansea.linux.org.uk> <20030817080901.GA3754@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030817080901.GA3754@suse.de>; from olh@suse.de on Sun, Aug 17, 2003 at 10:09:01AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 17, 2003 at 10:09:01AM +0200, Olaf Hering wrote:
> Paul, do you want to fill in some content in that proc file?

No!  proc_info is deprecated in 2.6 and you should not add a new
implementation.  If you want to expose information to userland
use sysfs.

