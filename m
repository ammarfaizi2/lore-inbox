Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261400AbVACGpK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261400AbVACGpK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 01:45:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261398AbVACGpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 01:45:09 -0500
Received: from chop.phpwebhosting.com ([66.132.134.9]:39375 "HELO
	chop.phpwebhosting.com") by vger.kernel.org with SMTP
	id S261400AbVACGpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 01:45:03 -0500
Subject: RE: Kernel 2.6.10 Can't Open Initial Console on FC3
From: Colin Charles <byte@aeon.com.my>
To: Development discussions related to Fedora Core 
	<fedora-devel-list@redhat.com>
Cc: jwendel10@comcast.net, mikeserv@bmts.com, zaitcev@redhat.com,
       Fedora List <fedora-list@redhat.com>,
       Linux Newbie <linux-newbie@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3k77vr$fs05t3@mxip08a.cluster1.charter.net>
References: <3k77vr$fs05t3@mxip08a.cluster1.charter.net>
Content-Type: text/plain
Organization: ArenaTechniques.com / ByteBot.Net
Date: Mon, 03 Jan 2005 11:09:28 +0800
Message-Id: <1104721768.32006.180.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-01-01 at 10:05 -0600, Joseph D. Wagner wrote:
> They tell me there's a way to make it work without initrd, but it's
> ugly, messy, and not recommended:
> 
> http://fedora.redhat.com/docs/udev/
> 
> I haven't yet tested to see if it works with initrd and without
> support for hotplug devices, but from the documentation I've read my
> money is on no.

It does work. For quite a while on the PPC tree, we ended up doing some
manual MAKEDEVs to make it work. IIRC, booting with selinux=0 might have
been required as well

(this was in the pre-FC-3 rawhide days)
-- 
Colin Charles, byte@aeon.com.my
http://www.bytebot.net/
"First they ignore you, then they laugh at you, then they fight you, 
then you win." -- Mohandas Gandhi

