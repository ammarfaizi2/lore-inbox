Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267021AbTAJS6b>; Fri, 10 Jan 2003 13:58:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266377AbTAJS4t>; Fri, 10 Jan 2003 13:56:49 -0500
Received: from air-2.osdl.org ([65.172.181.6]:42669 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S266615AbTAJS4b>;
	Fri, 10 Jan 2003 13:56:31 -0500
Date: Fri, 10 Jan 2003 11:01:26 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Andi Kleen <ak@suse.de>
cc: <Valdis.Kletnieks@vt.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5] speedup kallsyms_lookup
In-Reply-To: <20030110171950.GA6064@wotan.suse.de>
Message-ID: <Pine.LNX.4.33L2.0301101055030.19536-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jan 2003, Andi Kleen wrote:

| On Fri, Jan 10, 2003 at 12:13:48PM -0500, Valdis.Kletnieks@vt.edu wrote:
| > On Fri, 10 Jan 2003 17:12:12 +0100, Andi Kleen <ak@suse.de>  said:
| > >
| > > > So the end-result of the discussion is, "What should really happen here?"
| > > > and "What, if anything, do you want me to do?"
| > >
| > > IMHO best would be to get rid of /proc/*/wchan and keep the kallsyms
| > > lookup slow, simple and stupid.
| >
| > And replace the current /proc/*/wchan functionality with what?
|
| Ctrl-Rollen (or whatever the key is called on your keyboard) on the console,
| like in all previous linux releases.

Ctrl-ScrollLock on mine if I'm following you correctly.
Same as Sysrq-P if sysrq is enabled, except that the former
is always available.

Are there other similar functions that are available without
Sysrq enabled?  If so, where can I find info about them?
(other than drivers/char/keyboard.c :)

| Note /proc/*/wchan is not in 2.4.
|
| Also you still have WCHAN in ps, just not a full backtrace.

-- 
~Randy

