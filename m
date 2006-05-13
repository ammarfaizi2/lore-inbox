Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932401AbWEMMMh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbWEMMMh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 08:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932399AbWEMMMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 08:12:37 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:3733 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932401AbWEMMMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 08:12:37 -0400
Date: Sat, 13 May 2006 13:12:29 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Olaf Hering <olh@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       schwidefsky@de.ibm.com
Subject: Re: [PATCH] add raw driver Kconfig entry for s390
Message-ID: <20060513121229.GA14620@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Olaf Hering <olh@suse.de>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com
References: <20060513115255.GA11955@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060513115255.GA11955@suse.de>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 13, 2006 at 01:52:56PM +0200, Olaf Hering wrote:
> From: Ihno Krumreich <ihno@suse.de>
> 
> The raw module is not enabled on s390/s390x
> During SLES9 and SLES10 development IBM filed bugs about the missing raw
> driver. Avoid that for SLES11 by adding it to the other char driver
> entries.

The raw driver ist deptrecated amd your friends at IBM should better stop
using it ASAP.  It certainly won't survive until SLES11 is due if you
guys stick to your current release schedule.
