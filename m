Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263009AbTIVGNj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 02:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263011AbTIVGNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 02:13:39 -0400
Received: from yonge.cs.toronto.edu ([128.100.1.8]:18431 "HELO
	yonge.cs.toronto.edu") by vger.kernel.org with SMTP id S263009AbTIVGNi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 02:13:38 -0400
Date: Mon, 22 Sep 2003 02:12:22 -0400
From: Behdad Esfahbod <behdad@cs.toronto.edu>
X-X-Sender: behdad@qew.cs
To: Patrick Mochel <mochel@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: standby and suspend with acpi in 2.6.0-test5
In-Reply-To: <Pine.LNX.4.33.0309160857500.958-100000@localhost.localdomain>
Message-ID: <Pine.GSO.4.58.0309220210210.14779@qew.cs>
References: <Pine.LNX.4.33.0309160857500.958-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Sep 2003, Patrick Mochel wrote:
> > With 2.6.0-test5, reading the docs, I found that to standby of
> > suspend, I should try writing to /sys/power/state, but doing so
> > makes it to try load apm module as it opens /dev/apmbios.  So the
> > questions are:
> >
> > 	* Is swsusp patches merged with the kernel?
> > 	* How should I suspend/standby with acpi enabled?
> > 	* Where is /proc/acpi/sleep gone?  It used to kinda work.
>
> Please try -test5-mm2, it has the latest updates to all the PM code.

Didn't helped.  I have /proc/acpi/sleep back.  echo 3 >
/proc/acpi/sleep seems to work but I cannot wake it up!  So I
remove the battery and AC adaptor to get it off.  echo 4 and 5 do
nothing.  The /sys/power/state is not doing anything anymore.

> Thanks,
> 	Pat


Thanks to you,
behdad
