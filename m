Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933046AbWK0Srv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933046AbWK0Srv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 13:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933056AbWK0Srv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 13:47:51 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:54210 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S933046AbWK0Sru (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 13:47:50 -0500
Date: Mon, 27 Nov 2006 19:47:48 +0100
From: bert hubert <bert.hubert@netherlabs.nl>
To: Eric Van Hensbergen <ericvh@hera.kernel.org>
Cc: linux-kernel@vger.kernel.org, dm-devel@redhat.com, ming@acis.ufl.edu,
       ericvh@gmail.com
Subject: Re: [RFC][PATCH] dm-cache: block level disk cache target for device mapper
Message-ID: <20061127184748.GA11219@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <bert.hubert@netherlabs.nl>,
	Eric Van Hensbergen <ericvh@hera.kernel.org>,
	linux-kernel@vger.kernel.org, dm-devel@redhat.com, ming@acis.ufl.edu,
	ericvh@gmail.com
References: <200611271826.kARIQYRi032717@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611271826.kARIQYRi032717@hera.kernel.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2006 at 06:26:34PM +0000, Eric Van Hensbergen wrote:
> This is the first cut of a device-mapper target which provides a write-back
> or write-through block cache.  It is intended to be used in conjunction with
> remote block devices such as iSCSI or ATA-over-Ethernet, particularly in
> cluster situations.

How does this work in practice? In other words, what is a typical actual
configuration?

There is a remote block device, and a local one, and these are kept into
sync in some way?

Thanks.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://netherlabs.nl              Open and Closed source services
