Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261954AbTIPQEI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 12:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261975AbTIPQEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 12:04:07 -0400
Received: from fw.osdl.org ([65.172.181.6]:34491 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261954AbTIPQBb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 12:01:31 -0400
Date: Tue, 16 Sep 2003 08:58:28 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Behdad Esfahbod <behdad@cs.toronto.edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: standby and suspend with acpi in 2.6.0-test5
In-Reply-To: <Pine.GSO.4.44.0309160916180.15025-100000@dvp.cs>
Message-ID: <Pine.LNX.4.33.0309160857500.958-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> With 2.6.0-test5, reading the docs, I found that to standby of
> suspend, I should try writing to /sys/power/state, but doing so
> makes it to try load apm module as it opens /dev/apmbios.  So the
> questions are:
> 
> 	* Is swsusp patches merged with the kernel?
> 	* How should I suspend/standby with acpi enabled?
> 	* Where is /proc/acpi/sleep gone?  It used to kinda work.

Please try -test5-mm2, it has the latest updates to all the PM code.

Thanks,


	Pat

