Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262210AbSLAROe>; Sun, 1 Dec 2002 12:14:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262215AbSLAROe>; Sun, 1 Dec 2002 12:14:34 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:63239 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262214AbSLAROe>; Sun, 1 Dec 2002 12:14:34 -0500
Date: Sun, 1 Dec 2002 17:21:56 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>,
       linux-security-module@wirex.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] LSM fix for stupid "empty" functions
Message-ID: <20021201172156.A17028@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Greg KH <greg@kroah.com>,
	Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>,
	linux-security-module@wirex.com, linux-kernel@vger.kernel.org
References: <20021201083056.GJ679@kroah.com> <87k7it3cbl.fsf@goat.bogus.local> <20021201181227.GC8829@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021201181227.GC8829@kroah.com>; from greg@kroah.com on Sun, Dec 01, 2002 at 10:12:27AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 01, 2002 at 10:12:27AM -0800, Greg KH wrote:
> Does the kernel work if data structures are in ROM?  I would think that
> lots of variables in the kernel would have this problem :)

The nommu ports support .text in rom.  SGI NUMA plattforms support
kernel text replication which has the same problems.

