Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262654AbTI1Rko (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 13:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262656AbTI1Rko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 13:40:44 -0400
Received: from fw.osdl.org ([65.172.181.6]:31907 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262654AbTI1Rkm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 13:40:42 -0400
Date: Sun, 28 Sep 2003 10:40:38 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: pavel@ucw.cz
cc: =?ISO-8859-1?Q?kernel_list?= <linux-kernel@vger.kernel.org>,
       =?ISO-8859-1?Q??= =?ISO-8859-1?Q?Patrick_Mochel?= 
	<mochel@osdl.org>
Subject: =?ISO-8859-1?Q?Re:_pm:_Revert_swsusp_to_2.6.0-test3_?=
In-Reply-To: <20030928100620.5FAA63450F@smtp-out2.iol.cz>
Message-ID: <Pine.LNX.4.44.0309281038270.6307-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 28 Sep 2003 pavel@ucw.cz wrote:
> 
> This should not be warring patch. Pat
> already has variant in his tree,
> feel free to pull from him - but it
> would be nice to have working swsusp
> in -test6. --p

Ok. In that case, can we remove the '#if 0' blocks entirely, or at least 
add a big comment on why they are there but disabled?

I'd also like to have some kind of readme or similar on the different 
suspend/resume issues, and why we have two different approaches. Hmm?

		Linus

