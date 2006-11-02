Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752640AbWKBF1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752640AbWKBF1y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 00:27:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752644AbWKBF1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 00:27:54 -0500
Received: from smtp-out.google.com ([216.239.45.12]:25990 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1752640AbWKBF1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 00:27:53 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:mime-version:to:cc:
	subject:references:in-reply-to:content-type:content-transfer-encoding;
	b=yrvAYX//OeaInVfvOpRIsxiHz80FUrBGNlX8TnV5nOh8G9fLFqvn79k5+L6YXFkXo
	g57j/vG60WlnVcce0mD7g==
Message-ID: <45498174.5070309@google.com>
Date: Wed, 01 Nov 2006 21:26:12 -0800
From: "Martin J. Bligh" <mbligh@google.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: Cornelia Huck <cornelia.huck@de.ibm.com>, Mike Galbraith <efault@gmx.de>,
       Andy Whitcroft <apw@shadowen.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Steve Fox <drfickle@us.ibm.com>
Subject: Re: 2.6.19-rc3-mm1 -- missing network adaptors
References: <20061031065912.GA13465@suse.de> <4546FB79.1060607@google.com> <20061031075825.GA8913@suse.de> <45477131.4070501@google.com> <20061031174639.4d4d20e3@gondolin.boeblingen.de.ibm.com> <4547833C.5040302@google.com> <20061031182919.3a15b25a@gondolin.boeblingen.de.ibm.com> <4547FABE.502@google.com> <20061101020850.GA13070@suse.de> <45480241.2090803@google.com> <20061102052409.GA9642@suse.de>
In-Reply-To: <20061102052409.GA9642@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>> Even with CONFIG_SYSFS_DEPRECATED enabled?  For some reason I'm guessing
>>> that you missed that suggestion a while back...
>> Yes - Enabling CONFIG_SYSFS_DEPRECATED didn't help.
> 
> Ok, you are correct, for a stupid reason, this option didn't correctly
> work for a range of device types (I can get into the gory details if
> anyone really cares...)
> 
> I've now fixed this up, and a few other bugs that I kept tripping on
> (which others also hit), and have refreshed my tree so that the next -mm
> will be much better in this area.
> 
> If the problem persists (and I've built a zillion different kernels in
> different configurations today testing to make sure it doesn't), please
> let me know.
> 
> I can post updated patches here if people want them.
> 
> thanks for everyone's patience, I appreciated it.

Thanks for fixing this up. If you could post a diff somewhere against
either mainline or -mm, would make it easy to run through
test.kernel.org before you wake up tommorow ;-)

Thanks,

M.
