Return-Path: <linux-kernel-owner+w=401wt.eu-S1161082AbXAHXAw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161082AbXAHXAw (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 18:00:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161111AbXAHXAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 18:00:51 -0500
Received: from ns2.lanforge.com ([66.165.47.211]:39193 "EHLO ns2.lanforge.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161082AbXAHXAs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 18:00:48 -0500
Message-ID: <45A2CD0A.3010405@candelatech.com>
Date: Mon, 08 Jan 2007 15:00:26 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Theodore Tso <tytso@mit.edu>, Ben Greear <greearb@candelatech.com>,
       Alan <alan@lxorguk.ukuu.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ext3 file system went read-only in 2.6.18.2 (plus hacks)
References: <45A2B9DA.20104@candelatech.com> <20070108220544.0febd10b@localhost.localdomain> <45A2C32D.4080101@candelatech.com> <20070108225324.GA16474@thunk.org>
In-Reply-To: <20070108225324.GA16474@thunk.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Tso wrote:
> Well, the filesystem obviously got corrupted.  The only question is
> *why* it got corrupted.  It could be memory corruption, or a bug in
> your propietary kernel patches, or some kind of hardware issue with
> the CF device.  There's really no way to say for sure.

Ok.  I certainly can't guarantee my code is not somehow causing
the problem.

> Were there any error messages in the system log from the device
> driver?

I looked and did not see anything obvious.  The file system
was not overly full (49MB free, not counting the reserved
space for the root user.)

I appreciate you looking at the report.  If we see it again or
manage to find some way to reliably reproduce this on other
hardware, I will of course let you know.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

