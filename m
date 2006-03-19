Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932107AbWCSPMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbWCSPMJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 10:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932108AbWCSPMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 10:12:08 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:64920 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932107AbWCSPMH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 10:12:07 -0500
To: Paul Jackson <pj@sgi.com>
Cc: akpm@osdl.org, Simon.Derr@bull.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Cpuset: remove unnecessary NULL check
References: <20060319085743.18841.45970.sendpatchset@jackhammer.engr.sgi.com>
	<m1acbmzfw5.fsf@ebiederm.dsl.xmission.com>
	<20060319065614.371823f2.pj@sgi.com>
From: ebiederm@xmission.com (Eric W. Biederman)
In-Reply-To: <20060319065614.371823f2.pj@sgi.com> (Paul Jackson's message of
 "Sun, 19 Mar 2006 06:56:14 -0800")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Date: Sun, 19 Mar 2006 08:10:52 -0700
Message-ID: <m1wteqxyf7.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> writes:

> Eric wrote:
>> Comments that refer to a nebulous hack ...
>
> Well, in this case, it wasn't so nebulous, to me anyway.

Right.  The core problem was there was not enough context to see
what the dependency was from the comment.  Having to read
another comment to understand the comment you are reading
usually breaks after a while.

Now that we have git the problem is less severe because we
can look in the history and see what the comment meant when
it was written but that is still a hassle.

> Patch coming soon.

Thanks.

Eric
