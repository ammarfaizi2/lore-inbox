Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270884AbTGQUeN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 16:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270889AbTGQUeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 16:34:13 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12452 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S270884AbTGQUeM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 16:34:12 -0400
Message-ID: <3F170BB7.5030806@pobox.com>
Date: Thu, 17 Jul 2003 16:48:55 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: schlicht@uni-mannheim.de, ricardo.b@zmail.pt, linux-kernel@vger.kernel.org
Subject: Re: SET_MODULE_OWNER
References: <1058446580.18647.11.camel@ezquiel.nara.homeip.net>	<3F16C190.3080205@pobox.com>	<200307171756.19826.schlicht@uni-mannheim.de>	<3F16C83A.2010303@pobox.com>	<20030717125942.7fab1141.davem@redhat.com>	<3F170589.50005@pobox.com> <20030717131902.76c68c56.davem@redhat.com>
In-Reply-To: <20030717131902.76c68c56.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> Module reference counting added complications to net device
> handling, and once I killed it off we could begin addressing

Coding is tough, let's go shopping.


> all of the real bugs that exist with network devices.  For example,
> now that we're foreced to make net devices dynamic memory in all
> cases we can deal with dangling procfs/sysfs references to the device
> sanely.  Fixing that was not possible with module refcounting.

rmmod is now completely pointless, and developers now have one less 
useful tool in their toolbox.

I code all the time doing "modprobe ; test ; rmmod", and that's now 
impossible.

	Jeff



