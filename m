Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261545AbVBRWnU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261545AbVBRWnU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 17:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261544AbVBRWnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 17:43:20 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:55211 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261543AbVBRWnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 17:43:17 -0500
Subject: Re: cciss CSMI via sysfs for 2.6
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Greg KH <greg@kroah.com>
Cc: Christoph Hellwig <hch@infradead.org>, mike.miller@hp.com,
       Linux Kernel <linux-kernel@vger.kernel.org>, mochel@osdl.org,
       Andrew Morton <akpm@osdl.org>, eric.moore@lsil.com,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <20050218200552.GC20171@kroah.com>
References: <20050216164512.GA5734@beardog.cca.cpqcorp.net>
	 <20050218194628.GA24583@infradead.org>  <20050218200552.GC20171@kroah.com>
Content-Type: text/plain
Date: Fri, 18 Feb 2005 16:42:57 -0600
Message-Id: <1108766577.5764.29.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-02-18 at 12:05 -0800, Greg KH wrote:
> For a device?  It seems a huge overkill to add this attribute for
> _every_ device in the system, when only a small minority can actually
> use it.  Just put it as a default scsi or transport class attribute
> instead.

Actually, we might be able to do this as a simple attribute container
rather than a transport class, but I agree, it's not a generic property
of every device.

James


