Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbTEDSYW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 14:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261339AbTEDSYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 14:24:22 -0400
Received: from sol.cc.u-szeged.hu ([160.114.8.24]:34693 "EHLO
	sol.cc.u-szeged.hu") by vger.kernel.org with ESMTP id S261326AbTEDSYV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 14:24:21 -0400
Date: Sun, 4 May 2003 20:36:48 +0200 (CEST)
From: Geller Sandor <wildy@petra.hos.u-szeged.hu>
To: Chuck Ebbert <76306.1226@compuserve.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: compile fix for IBM PCI hotplug driver (linux 2.4.21rc1-ac4)
In-Reply-To: <200305041040_MC3-1-3755-1BD@compuserve.com>
Message-ID: <Pine.LNX.4.44.0305042033050.538-100000@petra.hos.u-szeged.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 May 2003, Chuck Ebbert wrote:

>
> >               if(create_file_name (slot_cur, buf)==0)
>
>   Wow.  Three whitespace violations on one line:
>
>         - no space after 'if'
>         - space between function and args
>         - no space around '==' operator
>
> I know you didn't write that, I just had to comment because it almost
> hurts to look at it...
>
> >-                      snprintf (slot_cur->hotplug_slot->name, 30, "%s", );
> >+                      snprintf (slot_cur->hotplug_slot->name, 30, "%s" );
>
>
>   Doesn't this need a fourth parameter here instead of just
> removing the comma?

Yes, Andreas Haumer fixed the compile problems correctly in his post.

  Geller Sandor <wildy@petra.hos.u-szeged.hu>

