Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263621AbTDWWRP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 18:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263631AbTDWWRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 18:17:15 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:20160 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S263621AbTDWWRO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 18:17:14 -0400
Date: Wed, 23 Apr 2003 15:18:50 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Werner Almesberger <wa@almesberger.net>
cc: Matthias Schniedermeyer <ms@citd.de>, Marc Giger <gigerstyle@gmx.ch>,
       linux-kernel <linux-kernel@vger.kernel.org>, pat@suwalski.net
Subject: Re: [Bug 623] New: Volume not remembered.
Message-ID: <1570840000.1051136330@flay>
In-Reply-To: <20030423191427.D3557@almesberger.net>
References: <21660000.1051114998@[10.10.2.4]> <20030423164558.GA12202@citd.de> <1508310000.1051116963@flay> <20030423183413.C1425@almesberger.net> <1560860000.1051133781@flay> <20030423191427.D3557@almesberger.net>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I'm more concerned with new installs, and the poor user having no idea
>> why his sound card "doesn't work". Been there myself. Pain in the ass.
> 
> Yes, but that's a user space problem too. Nothing prevents your
> distribution to crank up the volume to 100% also on a first-time
> installation.

100% would be stupid too. If the distro can pick a reasonable value,
the kernel can too. Thus the argument "push the problem into userspace"
doesn't do anything for me.
 
> The kernel should pick a value that's safe in all cases. And
> this is zero. Don't forget that there can be several seconds
> between the driver's initialization and the moment when the
> user-space utility gets to change the settings.

So if people want 0 volume for some reason, they can set *that*
in userspace. Windows can manage to do this without cocking it up. 
I don't see why we can't achieve it. 

M.

