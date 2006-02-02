Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422947AbWBBFhe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422947AbWBBFhe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 00:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422951AbWBBFhe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 00:37:34 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:33192 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1422947AbWBBFhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 00:37:32 -0500
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, Roland McGrath <roland@redhat.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] choose_new_parent: remove unused arg, sanitize
 exit_state check
References: <43E1106B.E1D73FE6@tv-sign.ru>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 01 Feb 2006 22:36:48 -0700
In-Reply-To: <43E1106B.E1D73FE6@tv-sign.ru> (Oleg Nesterov's message of
 "Wed, 01 Feb 2006 22:47:55 +0300")
Message-ID: <m1d5i6wccv.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> writes:

> 'child_reaper' arg is not used in choose_new_parent().
>
> "->exit_state >= EXIT_ZOMBIE" check is a leftover, was
> valid when EXIT_ZOMBIE lived in ->state var.
>
> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

Looks good.  I have been tripping over that extra parameter
in choose_new_parent for a while now.

Acked-by: Eric Biederman <ebiederm@xmission.com>
