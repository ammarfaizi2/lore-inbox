Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261221AbVG0Wza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbVG0Wza (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 18:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261182AbVG0Wxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 18:53:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51388 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261179AbVG0Wv0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 18:51:26 -0400
Date: Wed, 27 Jul 2005 15:51:20 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
cc: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/23] reboot-fixes
In-Reply-To: <20050727224711.GA6671@elf.ucw.cz>
Message-ID: <Pine.LNX.4.58.0507271550250.3227@g5.osdl.org>
References: <m1mzo9eb8q.fsf@ebiederm.dsl.xmission.com> <20050727025923.7baa38c9.akpm@osdl.org>
 <m1k6jc9sdr.fsf@ebiederm.dsl.xmission.com> <20050727104123.7938477a.akpm@osdl.org>
 <m18xzs9ktc.fsf@ebiederm.dsl.xmission.com> <20050727224711.GA6671@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 28 Jul 2005, Pavel Machek wrote:
> 
> Yes, I think we should do device_suspend(PMSG_FREEZE) in reboot path.

Considering how many device drivers that are likely broken, I disagree. 
Especially since Andrew seems to have trivially found a machine where it 
doesn't work.

		Linus
