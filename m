Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265306AbTBFDoB>; Wed, 5 Feb 2003 22:44:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265320AbTBFDoB>; Wed, 5 Feb 2003 22:44:01 -0500
Received: from air-2.osdl.org ([65.172.181.6]:45962 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265306AbTBFDoA>;
	Wed, 5 Feb 2003 22:44:00 -0500
Date: Wed, 5 Feb 2003 19:51:44 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: "Robert P. J. Day" <rpjday@mindspring.com>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: cleanup of filesystems menu
In-Reply-To: <Pine.LNX.4.44.0302041746230.17535-100000@dell>
Message-ID: <Pine.LNX.4.33L2.0302051936330.8974-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Feb 2003, Robert P. J. Day wrote:

| On Tue, 4 Feb 2003, Randy.Dunlap wrote:
|
| > Here are my comments on the filesystem menu:
| >
| > That "FS_POSIX_ACL" line is very odd.
| > What can be done about/with it?
|
| beats me.  i don't invent 'em, i just organize 'em.

In this case fs/Kconfig went from 1 entry of FS_POSIX_ACL to 2 of
them.  And the original one didn't contain any text after "bool",
so it wasn't presented to the user as a config option.
I.e., it's a derived (generated) config option value.

So the one with 'bool "FS_POSIX_ACL"' should be removed IMO.
It's confusing, especially without any 'help' text, which isn't
needed when it's hidden.

| > Quota and Automounter:  are they filesystems?
| > I know, you didn't change that.
| > Anyway, they are more like FS options or tools.
|
| again, i'm open to suggestions.  since this was just
| a first attempt, i only moved stuff around within the
| same menu for now.  i'm not sure where else these would
| go.

Yes, I would just leave this part as is for now and try go get
it merged based on feedback so far.

| > I would put the list under "Miscellaneous filesystems"
| > in alphabetical order.
|
| easy enough.
|
|
| > Did you modify "Network File Systems" or "Partition Types"?
|
| nope.

OK, that can be done separately (if at all).

| > Anyway, they are sort of in historical order and I would
| > put them in alpha order too unless there's some
| > compelling reason not to do that.
|
| also easy.

-- 
~Randy

