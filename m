Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751187AbVKJRoq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbVKJRoq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 12:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbVKJRoq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 12:44:46 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:43660 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751131AbVKJRop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 12:44:45 -0500
From: Junio C Hamano <junkio@cox.net>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] GIT 0.99.9g
References: <7vmzkc2a3e.fsf@assigned-by-dhcp.cox.net>
	<43737EC7.6090109@zytor.com>
Date: Thu, 10 Nov 2005 09:44:43 -0800
In-Reply-To: <43737EC7.6090109@zytor.com> (H. Peter Anvin's message of "Thu,
	10 Nov 2005 09:09:27 -0800")
Message-ID: <7v4q6k1jp0.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> May I *STRONGLY* urge you to name that something different. 
> "lost+found" is a name with special properties in Unix; for example, 
> many backup solutions will ignore a directory with that name.

Yeah, the original proposal (in TODO list) explicitly stated why
I chose lost-found instead of lost+found back then, and somebody
on the list (could have been Pasky but I may be mistaken) said
not to worry.  In any case, if we go the route Daniel suggests,
we would not be storing anything on the filesystem ourselves so
this would be a non-issue.


