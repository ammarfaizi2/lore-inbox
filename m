Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264343AbTKZU4y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 15:56:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264348AbTKZU4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 15:56:54 -0500
Received: from bee.hiwaay.net ([216.180.54.11]:59584 "EHLO mail.hiwaay.net")
	by vger.kernel.org with ESMTP id S264343AbTKZU4w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 15:56:52 -0500
Date: Wed, 26 Nov 2003 14:56:50 -0600
From: Chris Adams <cmadams@hiwaay.net>
To: linux-kernel@vger.kernel.org
Subject: Re: amanda vs 2.6
Message-ID: <20031126205650.GA1028742@hiwaay.net>
References: <fa.fdvoh2b.e4kag7@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0311261202050.1524@home.osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Once upon a time, Linus Torvalds <torvalds@osdl.org> wrote:
>And syslogd is stopped for some reason - either a bug, a mistaken SIGSTOP,
>or simply because the console has been stopped with a simple ^S.

It can also happen if there is a problem with DNS; syslogd tries to do a
DNS lookup to get the hostname to put in the record and can hang on that
if the DNS server is busy, hung, down, unreachable, etc.

_Really_ annoying when you are trying to log in to the DNS server to fix
a problem with DNS!
-- 
Chris Adams <cmadams@hiwaay.net>
Systems and Network Administrator - HiWAAY Internet Services
I don't speak for anybody but myself - that's enough trouble.
