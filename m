Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268340AbUHKXcv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268340AbUHKXcv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 19:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268331AbUHKXYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 19:24:39 -0400
Received: from omx1-ext.SGI.COM ([192.48.179.11]:56799 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S268346AbUHKXX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 19:23:29 -0400
Message-ID: <411AAABB.8070707@sgi.com>
Date: Wed, 11 Aug 2004 18:24:43 -0500
From: Patrick Gefre <pfg@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Altix I/O code reorganization
References: <200408042014.i74KE8fD141211@fsgi900.americas.sgi.com> <20040806141836.A9854@infradead.org>
In-Reply-To: <20040806141836.A9854@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm sending out a new patch set - the set of files will follow this email.

I'll add in this email the comments on the general comments and the comments on
the specific pach comments will be in the email for that updated patch - hopefully
that makes some kind of sense 8^). I didn't include the small bte change in this
set.


Christoph Hellwig wrote:
> On Wed, Aug 04, 2004 at 03:14:08PM -0500, Pat Gefre wrote:
> 
> 
> Yikes, this is truely horrible.  First your patch ordering doesn't make
> any sense, with just the first patch applied the system won't work at all.
> Please submit a series of _small_ patches going from A to B keeping the code
> working everywhere inbetween.
> 

This is a very BIG change.  However, the BIG change ends up with
very little code in the kernel.  The reason is because, we have enhanced the
functionalities in our Prom to actually configure and initialize all devices
in the system instead of just the BaseIO devices.

It is not practical to have small patches that will work independently.

The code base is now small enough that we should not have a problem
providing feedback.



> Your new directory structure is very bad.  Just stick all files into
> arch/ia64/sn/io/ instead of adding subdirectories for often just a single
> file.
> 

We do like our directory structures.  It provides very logical
separation of code files.


