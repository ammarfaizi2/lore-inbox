Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262029AbTEYLui (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 07:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbTEYLui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 07:50:38 -0400
Received: from quicksilver.ukc.ac.uk ([129.12.21.11]:18048 "EHLO
	quicksilver.ukc.ac.uk") by vger.kernel.org with ESMTP
	id S262029AbTEYLuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 07:50:37 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ben Collins <bcollins@debian.org>, Patrick Mochel <mochel@osdl.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Resend [PATCH] Make KOBJ_NAME_LEN match BUS_ID_SIZE
References: <Pine.LNX.4.44.0305242045050.1666-100000@home.transmeta.com>
From: Adam Sampson <azz@us-lot.org>
Organization: Don't wake me, 'cos I'm dreaming, and I might just stay inside again today.
Date: 25 May 2003 13:03:06 +0100
In-Reply-To: <Pine.LNX.4.44.0305242045050.1666-100000@home.transmeta.com>
Message-ID: <y2awugf2pz9.fsf@cartman.at.fivegeeks.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-UKC-Mail-System: No virus detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> How about just adding a sane
> 	int copy_string(char *dest, const char *src, int len)
[...]

If you're going to do this, it might make sense to call it "strlcpy"
for consistency with the OpenBSD-introduced function of the same name
that's getting included in a lot of userspace these days...

<http://www.courtesan.com/todd/papers/strlcpy.html>

-- 
Adam Sampson <azz@us-lot.org>                   <http://azz.us-lot.org/>
