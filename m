Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262854AbTJEBcb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 21:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262855AbTJEBcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 21:32:31 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:6084 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S262854AbTJEBca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 21:32:30 -0400
Date: Sun, 5 Oct 2003 02:31:57 +0100
From: Dave Jones <davej@redhat.com>
To: William Scott Lockwood III <vlad@lrsehosting.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Onboard LAN Asus A7V8X-X (VT6102 [Rhine-II])
Message-ID: <20031005013157.GA6474@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	William Scott Lockwood III <vlad@lrsehosting.com>,
	linux-kernel@vger.kernel.org
References: <20031004161037.05b9e5ee.davem@redhat.com> <002601c38ad3$650e14a0$0200a8c0@wsl3>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002601c38ad3$650e14a0$0200a8c0@wsl3>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 04, 2003 at 06:58:22PM -0500, William Scott Lockwood III wrote:
 > This motherboard has source included (but has an unfortunate advertising
 > clause) at the website for the onboard nic, but I can't make it work in
 > 2.4.22 - is this nic supported natively, or will it be?  I didn't find an
 > option for it in 2.4.22 or 2.6.0-test6. Is there any interest in a driver
 > for this board? It's a VIA VT6102 [Rhine-II].

CONFIG_VIA_RHINE should do the trick, though with the same chip on a
different board in 2.4.22, I had to boot with "acpi=off noapic"
This is now fixed in 2.4.23 iirc.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
