Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265511AbTFMTrk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 15:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265512AbTFMTrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 15:47:40 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:57093 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265511AbTFMTri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 15:47:38 -0400
Date: Fri, 13 Jun 2003 21:01:25 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Rocketport changes for 2.5.70-bk
Message-ID: <20030613210125.A7121@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <20030613195214.GA1260@kroah.com> <20030613195239.GB1260@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030613195239.GB1260@kroah.com>; from greg@kroah.com on Fri, Jun 13, 2003 at 12:52:39PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 13, 2003 at 12:52:39PM -0700, Greg KH wrote:
> ChangeSet 1.1308, 2003/06/13 12:36:16-07:00, Kurt.Robideau@comtrol.com
> 
> [PATCH] Rocket patch against 2.5.70-bk18
> 
> Here is rocket driver patch against 2.5.70-bk18.  Changes are:
> 
> -  Removed non-GPL license text from headers
> -  Removed check_region()/request_region() raciness
> -  Made the driver a >2.5 driver only (as you had suggested)

Please also remove all those silly indirection macros added
to rocket_int.h in the last update.

