Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266332AbUANPBq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 10:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266334AbUANPBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 10:01:46 -0500
Received: from sarvega.com ([161.58.151.164]:42258 "EHLO sarvega.com")
	by vger.kernel.org with ESMTP id S266332AbUANPBp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 10:01:45 -0500
Date: Wed, 14 Jan 2004 09:01:37 -0600
From: John Lash <jkl@sarvega.com>
To: Michael Lothian <s0095670@sms.ed.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Catch 22
Message-Id: <20040114090137.5586a08c.jkl@sarvega.com>
In-Reply-To: <400554C3.4060600@sms.ed.ac.uk>
References: <400554C3.4060600@sms.ed.ac.uk>
X-Mailer: Sylpheed version 0.9.6claws71 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jan 2004 14:40:03 +0000
Michael Lothian <s0095670@sms.ed.ac.uk> wrote:

> Just thaought I'd let you know about my experiences with Mandrake using
> the 2.4 and 2.6 kernels on my new hardware which is primaraly a Asus
> A7V600 (KT600) Motherboard and Radeon 9600XT
> 
> Under 2.4 my ATA hard drak is mounted under /dev/hda where as under 2.6
> is /dev/hde so there is no wasy way to switch between them with lilo and
> /etc/fstab needing to be changed
> 

At least in this case, you should be able to use volume labels for the
filesystems instead of the actual device names. Check out tune2fs -L. You then
reference the volume label in your fstab.

With lilo, you can specify that boot disk and root disk on the command line.
Also you can point lilo to a different config file using lilo -C. Not seamless
but should allow you to bounce back and forth w/o editing files....

Sorry, I'm not familiar with the rest.....

--john
