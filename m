Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266621AbUGVHKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266621AbUGVHKr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 03:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266821AbUGVHKq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 03:10:46 -0400
Received: from 209-87-233-98.storm.ca ([209.87.233.98]:5788 "EHLO
	ottawa.interneqc.com") by vger.kernel.org with ESMTP
	id S266621AbUGVHKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 03:10:46 -0400
Date: Thu, 22 Jul 2004 03:08:31 -0400
From: Greg KH <greg@kroah.com>
To: John Rose <johnrose@austin.ibm.com>
Cc: Greg KH <gregkh@us.ibm.com>, Mike Wortman <wortman@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: pci_bus_lock question
Message-ID: <20040722070830.GB21907@kroah.com>
References: <1090447841.544.7.camel@sinatra.austin.ibm.com> <1090448467.544.10.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1090448467.544.10.camel@sinatra.austin.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2004 at 05:21:08PM -0500, John Rose wrote:
> But then, most of these violations are in __init functions.  I think I
> just answered my own question :)

Yes, we don't protect the lists in those __init functions, as it isn't
needed at that point in time.

thanks,

greg k-h
