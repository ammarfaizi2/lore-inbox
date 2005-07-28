Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261544AbVG1O4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261544AbVG1O4x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 10:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261579AbVG1O4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 10:56:48 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:53666 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261575AbVG1OzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 10:55:06 -0400
To: Pavel Machek <pavel@suse.cz>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/23] reboot-fixes
References: <m1mzo9eb8q.fsf@ebiederm.dsl.xmission.com>
	<20050727025923.7baa38c9.akpm@osdl.org>
	<m1k6jc9sdr.fsf@ebiederm.dsl.xmission.com>
	<20050727104123.7938477a.akpm@osdl.org>
	<m18xzs9ktc.fsf@ebiederm.dsl.xmission.com>
	<20050727224711.GA6671@elf.ucw.cz>
	<Pine.LNX.4.58.0507271550250.3227@g5.osdl.org>
	<20050727225334.GC6529@elf.ucw.cz>
	<m1oe8n7s4v.fsf@ebiederm.dsl.xmission.com>
	<20050728074344.GH6529@elf.ucw.cz>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 28 Jul 2005 08:54:04 -0600
In-Reply-To: <20050728074344.GH6529@elf.ucw.cz> (Pavel Machek's message of
 "Thu, 28 Jul 2005 09:43:44 +0200")
Message-ID: <m1oe8n0ynn.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> writes:

> I always thought that device_shutdown is different phase -- the one
> with interrupts disabled...

Nope.  device_shutdown runs before interrupts are disabled.

Eric
