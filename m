Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265136AbUFHADQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265136AbUFHADQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 20:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265137AbUFHADQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 20:03:16 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31402 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265136AbUFHADM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 20:03:12 -0400
Date: Tue, 8 Jun 2004 01:03:10 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, Al Viro <viro@math.psu.edu>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Finding user/kernel pointer bugs
Message-ID: <20040608000310.GL12308@parcelfarce.linux.theplanet.co.uk>
References: <1086652124.14180.5.camel@dooby.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1086652124.14180.5.camel@dooby.cs.berkeley.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2004 at 04:48:44PM -0700, Robert T. Johnson wrote:
> - cqual requires _zero_ annotations in device drivers.
> 
>   Once the generic driver interfaces have been annotated, all device
>   drivers can be checked against these annotations without any further
>   effort.  This is critical, since annotating the thousands of device
>   drivers in linux will be extremely difficult and take months.

Aha, so you have never actually bothered to read the damn things.  Two words:
ioctl code.

Another thing: two weeks had been enough to practically eliminate noise in
net/*, sound/*, large parts of drivers/*.  The only real difficulty I've
noticed was one with holding the breakfast down while reading some of more...
colourful code.

And one more: counting drivers that do not have a single __user in them
is meaningless for so many reasons it's not even funny.

Now would it be too much to ask the esteemed sir to piss off and not return
until sir acquires a modicum of clue?
