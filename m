Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266202AbUAGKXp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 05:23:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266203AbUAGKXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 05:23:45 -0500
Received: from ns.suse.de ([195.135.220.2]:37858 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266202AbUAGKXn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 05:23:43 -0500
Date: Wed, 7 Jan 2004 11:23:40 +0100
From: Olaf Hering <olh@suse.de>
To: Rob Landley <rob@landley.net>
Cc: Rob Love <rml@ximian.com>, Andries Brouwer <aebr@win.tue.nl>,
       Pascal Schmidt <der.eremit@email.de>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: udev and devfs - The final word
Message-ID: <20040107102340.GB22770@suse.de>
References: <18Cz7-7Ep-7@gated-at.bofh.it> <20040101001549.GA17401@win.tue.nl> <1072917113.11003.34.camel@fur> <200401010634.28559.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200401010634.28559.rob@landley.net>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Thu, Jan 01, Rob Landley wrote:

> Fundamental problem: "Unique" depends on the other devices in the system.  You 
> can't guarantee unique by looking at one device, more or less by definition.

This is certainly not true. (well, maybe for a few device types).

Almost everything can be reached via a well defined bus (or more than
one bus). Each of them does obviously require an identifier. Thats the
hardware part.
Software tends to put a unique identifier into the 'logical' stuff, like
filesystem UUIDs.
So you can construct a unique device node for every device in the
system. And this will work even across distributions!
Stuff like sda3, mouse1 or dsp0 will obviously break. It just happend to
work because everyone on this list knows what to do and where to look.

Sure, there are exceptions, like 2 identical mice, or 2 identical USB
audio devices. But this cant be fixed.

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
