Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262813AbTHaWMe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 18:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262814AbTHaWMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 18:12:34 -0400
Received: from TEST.13thfloor.at ([212.16.62.51]:19405 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S262813AbTHaWMc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 18:12:32 -0400
Date: Mon, 1 Sep 2003 00:12:30 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: "Zach, Yoav" <yoav.zach@intel.com>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: non-readable binaries - binfmt_misc 2.6.0-test4
Message-ID: <20030831221230.GA9725@DUK2.13thfloor.at>
Mail-Followup-To: "Zach, Yoav" <yoav.zach@intel.com>, akpm@osdl.org,
	torvalds@osdl.org, linux-kernel@vger.kernel.org
References: <2C83850C013A2540861D03054B478C0601CF64C8@hasmsx403.iil.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2C83850C013A2540861D03054B478C0601CF64C8@hasmsx403.iil.intel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 01, 2003 at 12:41:23AM +0300, Zach, Yoav wrote:
> The proposed patch solves a problem for interpreters that need to
> execute a non-readable file, which cannot be read in userland. To handle
> such cases the interpreter must have the kernel load the binary on its
> behalf. The proposed patch handles this case by telling binfmt_misc, by
> a special flag in the registration string, to open the binary for
> reading and pass its descriptor as argv[1], instead of passing the
> binary's path. Old behavior of binfmt_misc is kept for interpreters
> which do not specify this special flag. The patch is against
> linux-2.6.0-test4. A similar one was posted twice on the list, on Aug.
> 14 and 21, without significant response.

okay, here is your response!

what non-readable files need to be interpreted/executed?
why is this case relevant?
why not simply make it user-land readable?

best,
Herbert

