Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264528AbUDUKjm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264528AbUDUKjm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 06:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264534AbUDUKjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 06:39:42 -0400
Received: from post1.dk ([62.242.36.44]:37131 "EHLO post1.dk")
	by vger.kernel.org with ESMTP id S264528AbUDUKjl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 06:39:41 -0400
Content-Disposition: inline
Content-Transfer-Encoding: binary
MIME-Version: 1.0
To: "Peter Kjellerstedt" <peter.kjellerstedt@axis.com>
Subject: Re: [RFC] kbuild: Documentation - how to build external modules
From: sam@ravnborg.org
Reply-To: sam@ravnborg.org
Cc: "Sam Ravnborg" <sam@ravnborg.org>, <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
X-Mailer: acmemail <URL:http://www.astray.com/acmemail/>
Message-Id: <20040421103940.49AF115C2A@post1.dk>
Date: Wed, 21 Apr 2004 12:39:40 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>What about external modules that need to be configured
>using make config & co? Is that possible with this system?

No, this is not possible for now.
I have thought about a few ways of doing this.
What I plan to look at is something where the local Kconfig
file is read along with the .config for the kernel.
The user will then anly be allowed to tweak config symbols
defined for the external module, the kernel paramerets are not
visible, and cannot be modified.

But this requires some kconfig tweaking, and first priority is
to get the basic funtionality working so all (most) people
are happy with it.

If anyone has better ideas for handling Kconfig files for external
modules please tell so.

  Sam
