Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264434AbTL3Ajr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 19:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264444AbTL3Ajr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 19:39:47 -0500
Received: from smtp1.fre.skanova.net ([195.67.227.94]:38388 "EHLO
	smtp1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S264434AbTL3Ajp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 19:39:45 -0500
To: sogentoo <sogentoo@katamail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 and PS/2 wheel mouse
References: <3FF0B54E.7050006@katamail.com>
From: Peter Osterlund <petero2@telia.com>
Date: 30 Dec 2003 01:39:37 +0100
In-Reply-To: <3FF0B54E.7050006@katamail.com>
Message-ID: <m2wu8ff8ae.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sogentoo <sogentoo@katamail.com> writes:

> I've a problem with kernel 2.6.0 and a simple PS/2 wheel mouse
> Logitech or A4tech.
> Mouse doesn't run
> with other kernel it's ok
> Kernel is configurated in a correct way (I think), but in no way it runs.

What happens if you run:

        /sbin/modprobe psmouse

manually? Does the mouse start to work? Is anything reported in dmesg?
What kernel modules are loaded?

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
