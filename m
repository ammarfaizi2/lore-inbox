Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262934AbVEHVJH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262934AbVEHVJH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 17:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262966AbVEHVJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 17:09:06 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:20909 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S262934AbVEHVJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 17:09:01 -0400
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: jdow <jdow@earthlink.net>, James Purser <purserj@ksit.dynalias.com>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       LKML <linux-kernel@vger.kernel.org>, GIT <git@vger.kernel.org>
Subject: Re: [PATCH] Really *do* nothing in while loop
References: <20050508093440.GA9873@cip.informatik.uni-erlangen.de>
	<427DE086.40307@tls.msk.ru> <1115551204.3085.0.camel@kryten>
	<12e801c553c1$c454ea20$1225a8c0@kittycat>
	<427DFAB8.5050000@tls.msk.ru>
From: Junio C Hamano <junkio@cox.net>
Date: Sun, 08 May 2005 14:08:58 -0700
In-Reply-To: <427DFAB8.5050000@tls.msk.ru> (Michael Tokarev's message of
 "Sun, 08 May 2005 15:40:40 +0400")
Message-ID: <7vy8ap4e8l.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "MT" == Michael Tokarev <mjt@tls.msk.ru> writes:

MT> As I already said, deflate() in this case does only ONE iteration.
MT> stream.avail_in is NOT changed in the loop (except of the deflate()
MT> itself, where it will be set to 0 - provided out buffer have enouth
MT> room)....

Just a stupid question, but what happens when we do not have
enough room in the buffer?

