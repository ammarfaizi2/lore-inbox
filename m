Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751460AbWFTWtU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbWFTWtU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 18:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751458AbWFTWtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 18:49:20 -0400
Received: from xenotime.net ([66.160.160.81]:26568 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751460AbWFTWtT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 18:49:19 -0400
Date: Tue, 20 Jun 2006 15:52:03 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Jim Cromie <jim.cromie@gmail.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch -mm 20/20 RFC] chardev: GPIO for SCx200 & PC-8736x: add
 sysfs-GPIO interface
Message-Id: <20060620155203.c700cf53.rdunlap@xenotime.net>
In-Reply-To: <44986DBB.2040206@gmail.com>
References: <448DB57F.2050006@gmail.com>
	<cfe85dfa0606121150y369f6beeqc643a1fe5c7ce69b@mail.gmail.com>
	<44944D14.2000308@gmail.com>
	<20060619222223.8f5133a9.akpm@osdl.org>
	<44985321.3020609@gmail.com>
	<20060620131440.9c9b0999.rdunlap@xenotime.net>
	<44985D51.8050200@gmail.com>
	<20060620135249.7f13d042.rdunlap@xenotime.net>
	<44986DBB.2040206@gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jun 2006 15:50:51 -0600 Jim Cromie wrote:

> are you referring to the replacement patch for 20/20 ?
> The one that said RFC ??

Yes.

> heh - youre right, tho  :-}  I retract that patch.
> Forgive the over-wound (and in retrospect, kinda stunned) newbie !

Stunned by what?
Maybe you should skim over
  http://www.xenotime.net/linux/mentor/linux-mentoring-2006.pdf
<end plug>

> I'll spend some time making the Doc more coherent, and into an actual patch.
> I guess I was hoping for some comments before doing this..
> 
> Whats a good name for this file?  (for purposes of focusing the tone and 
> content)
>      Doc/sysfs/gpio-interface ?  Doc/hwmon/gpio-sysfs-interface ?

I like Documentation/hwmon/gpio-sysfs-interface, but if the driver(s)
don't live in drivers/hwmon/, then something like
Documentation/gpio/sysfs-interface makes sense to me.
I'd leave Doc/sysfs for sysfs details/internals.

---
~Randy
