Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261950AbSLARSs>; Sun, 1 Dec 2002 12:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262214AbSLARSs>; Sun, 1 Dec 2002 12:18:48 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:17669 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261950AbSLARSr>;
	Sun, 1 Dec 2002 12:18:47 -0500
Date: Sun, 1 Dec 2002 10:26:44 -0800
From: Greg KH <greg@kroah.com>
To: Christoph Hellwig <hch@infradead.org>,
       Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>,
       linux-security-module@wirex.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] LSM fix for stupid "empty" functions
Message-ID: <20021201182644.GD8829@kroah.com>
References: <20021201083056.GJ679@kroah.com> <87k7it3cbl.fsf@goat.bogus.local> <20021201181227.GC8829@kroah.com> <20021201172156.A17028@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021201172156.A17028@infradead.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 01, 2002 at 05:21:56PM +0000, Christoph Hellwig wrote:
> On Sun, Dec 01, 2002 at 10:12:27AM -0800, Greg KH wrote:
> > Does the kernel work if data structures are in ROM?  I would think that
> > lots of variables in the kernel would have this problem :)
> 
> The nommu ports support .text in rom.

But doesn't initialized variables live in .bss?  So we should be ok,
right?

thanks,

greg k-h
