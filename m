Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbTISFIZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 01:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261327AbTISFIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 01:08:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:17073 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261326AbTISFIW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 01:08:22 -0400
Date: Thu, 18 Sep 2003 22:05:42 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Thorsten Leemhuis <Thorsten_Leemhuis@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: User-Experiences 2.6.0-test5[-mm2]: General, Power-Management
 and tmscsim
Message-Id: <20030918220542.08e47374.rddunlap@osdl.org>
In-Reply-To: <20030919.4461700@thl.ct.heise.de>
References: <20030919.4461700@thl.ct.heise.de>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Sep 2003 04:46:17 GMT Thorsten Leemhuis <Thorsten_Leemhuis@gmx.de> wrote:

| [third attempt to send mail, seems the first two (send more then 18 and 
| 36 hours ago) didn't arrive at the list]
| 
| Hi *,
| 
| now that we're some time in the 2.6.0-test stage I thought to disturb
| development a bit by testing the new kernel ;-) . I'm mostly a normal
| linux "desktop" user with only minor programming experiences in C.
| 
| Base Distro was a Red Hat 9 System updated with some security updates. I
| also installed the initscripts and modutils rpm packages from
| http://people.redhat.com/arjanv/2.5/RPMS.kernel/
| 
| Hardware is an Athlon XP 2400+ on an Asus A7V266-E (Via KT266-A).
[snip]
| 
| -----------------
| - gconfig currently doesn't work so nice:
| 
| -- Double-mouse-clicks in the checkboxes sometimes aren't noticed.
| Clicking in the _N M Y_ Fields in the full view works correct it seems.
| 
| -- In the _Split-View_ it will throw this segfault when trying to turn
| of/on something:
| ----start
[snip]
| ----end

I think that 'vi .config' and menuconfig get the most use.
I use xconfig occasionally, and have never used gconfig.

| -----------------
| - Using xconfig worked without problems. But IMHO some things are a bit
| disturbing:
| 
| -- Split-View: When do options appear in the left panel ("Support for
| USB Gadgets" and "Remove kernel Features")? It seems to me that these
| two are not a the right place there.
| Another thing: Sometimes Sub-Menus appear in a sub-field in the left
| tree-view (like Power Management -> CPU Frequency Scaling) and sometimes
| they only have an own sub-menu in the top-right panel (like Networking
| -> Ethernet (10 or 100 MBit)?

Yes, we could use more consistency there.
I find that sometimes it's easier to click on a different mehu item
completely than to up-level (backtrack) on a menu.

| -- Selecting "Code maturity level options -> Select only drivers
| expected to compile cleanly" is helpful but it would be nice if the
| config-system would show these drivers in a light grey (or something
| like that) and make them not-selectable.

I certainly like that suggestion.

[snip]

Thanks.
--
~Randy
