Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932108AbWCSPPa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbWCSPPa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 10:15:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932112AbWCSPPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 10:15:30 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:2969 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932108AbWCSPP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 10:15:29 -0500
To: Paul Jackson <pj@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Cpuset: remove unnecessary NULL check comment fix
References: <20060319150538.16855.53670.sendpatchset@jackhammer.engr.sgi.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 19 Mar 2006 08:14:14 -0700
In-Reply-To: <20060319150538.16855.53670.sendpatchset@jackhammer.engr.sgi.com> (Paul
 Jackson's message of "Sun, 19 Mar 2006 07:05:38 -0800")
Message-ID: <m1lkv6xy9l.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> writes:

> From: Paul Jackson <pj@sgi.com>
>
> Make the comments referring to the (ab)use of the top_cpuset
> during a tasks exit more explicit - hopefully clearer.
> This is now called "the_top_cpuset_hack", instead of the "Hack."

Ok.  Incremental patch that fixes comments.  Thanks this looks less confusing
to me.

Eric
