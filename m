Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263425AbUCYRM0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 12:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263448AbUCYRFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 12:05:44 -0500
Received: from fw.osdl.org ([65.172.181.6]:26245 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263440AbUCYRCj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 12:02:39 -0500
Date: Thu, 25 Mar 2004 09:02:32 -0800
From: Andrew Morton <akpm@osdl.org>
To: sleight@xs4all.nl
Cc: sleightofmind@xs4all.nl, m.c.p@wolk-project.de,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, len.brown@intel.com
Subject: Re: [BUG 2.6.5-rc2-bk5 and 2.6.5-rc2-mm3] ACPI seems to be broken
Message-Id: <20040325090232.15e8f59f.akpm@osdl.org>
In-Reply-To: <4062E986.2080508@xs4all.nl>
References: <200403251432.32787@WOLK>
	<4062E986.2080508@xs4all.nl>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Ballegooijen <sleightofmind@xs4all.nl> wrote:
>
>  with acpi on it can also run, but not if you supply vga=. I tried with
>  vga=0x317 and it stalls after "Freeing unused kernel memory". When i
>  turn off acpi using acpi=off and also supply vga=0x317 it continues
>  booting, but hangs during execution of bootscripts.

It would be interesting to try reverting probe_roms-02-fixes.patch and
probe_roms-01-move-stuff.patch.
