Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263323AbTIWHz3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 03:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263326AbTIWHz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 03:55:29 -0400
Received: from smithers.nildram.co.uk ([195.112.4.34]:39944 "EHLO
	smithers.nildram.co.uk") by vger.kernel.org with ESMTP
	id S263323AbTIWHz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 03:55:28 -0400
Date: Tue, 23 Sep 2003 08:57:07 +0100
Subject: Re: [PATCH] DM 1/6: Use new format_dev_t macro
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: Kevin Corry <kevcorry@us.ibm.com>, torvalds@osdl.org, akpm@zip.com.au,
       thornber@sistina.com, LKML <linux-kernel@vger.kernel.org>
To: viro@parcelfarce.linux.theplanet.co.uk
From: Joe Thornber <ethornber@yahoo.co.uk>
In-Reply-To: <20030922192909.GG7665@parcelfarce.linux.theplanet.co.uk>
Message-Id: <877B4BDE-ED9B-11D7-BE69-000393CA5730@yahoo.co.uk>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.552)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Monday, September 22, 2003, at 08:29 PM, 
viro@parcelfarce.linux.theplanet.co.uk wrote:

> On Mon, Sep 22, 2003 at 10:51:27AM -0500, Kevin Corry wrote:
>> Use the format_dev_t function for target status functions.
>
> [instead of bdevname, that is]
>
> It's wrong.  Simply because "sdb3" is immediately parsed by admin and
> 08:13 is nowhere near that convenient.  These are error messages, let's
> keep them readable.
>
>

No they are not just error messages, userland tools use them.

- Joe

