Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264859AbSIWGLp>; Mon, 23 Sep 2002 02:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264876AbSIWGLp>; Mon, 23 Sep 2002 02:11:45 -0400
Received: from air-2.osdl.org ([65.172.181.6]:20230 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S264859AbSIWGLp>;
	Mon, 23 Sep 2002 02:11:45 -0400
Date: Sun, 22 Sep 2002 23:13:04 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: "Rhoads, Rob" <rob.rhoads@intel.com>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       <cgl_discussion@osdl.org>,
       <hardeneddrivers-discuss@lists.sourceforge.net>
Subject: Re: [ANNOUNCE] Linux Hardened Device Drivers Project 
In-Reply-To: <D9223EB959A5D511A98F00508B68C20C0A53899F@orsmsx108.jf.intel.com>
Message-ID: <Pine.LNX.4.33L2.0209222252340.20873-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Sep 2002, Rhoads, Rob wrote:

| Project Announcement:
| --------------------
|
| Initially we've created a specification, a few kernel modules
| that implement a set of driver programming interfaces, and
| a sample device driver that demonstrates those interfaces.
| -

Only addressing spec bugs for now.
More comments tomorrow when I'm more awake.

section
3.1.1.1	"Table 2 takes a closer look at the fields...."
	No, it doesn't.

3.2.3	"The CONFIG_DRIVER_STATISTICS flag...."
	but section 5.1 calls it CONFIG_DRIVER_STATS.

3.3.2	"The CONFIG_DRIVER_STATISTICS build configuration option"
	should be CONFIG_DRIVER_DIAGNOSTICS
	and change "statistics support" to "diagnostics support"

3.4.2.7.3, example 2:  missing final '|' after "%s"

3.4.3.8.1, Comments on #defines:
	aren't several of these backwards?

3.4.3.8.3, last #define:  bad font change.

-- 
~Randy

