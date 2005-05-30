Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261790AbVE3Wad@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261790AbVE3Wad (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 18:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261793AbVE3Wad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 18:30:33 -0400
Received: from smtp.lnxw.com ([207.21.185.24]:42506 "EHLO smtp.lnxw.com")
	by vger.kernel.org with ESMTP id S261790AbVE3W3y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 18:29:54 -0400
Date: Mon, 30 May 2005 15:34:34 -0700
To: Karim Yaghmour <karim@opersys.com>
Cc: Esben Nielsen <simlo@phys.au.dk>, Nick Piggin <nickpiggin@yahoo.com.au>,
       kus Kusche Klaus <kus@keba.com>, James Bruce <bruce@andrew.cmu.edu>,
       "Bill Huey (hui)" <bhuey@lnxw.com>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050530223434.GC9972@nietzsche.lynx.com>
References: <Pine.OSF.4.05.10505301934001.31148-100000@da410.phys.au.dk> <429B61F7.70608@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429B61F7.70608@opersys.com>
User-Agent: Mutt/1.5.9i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2005 at 02:56:55PM -0400, Karim Yaghmour wrote:
> Which gets up back where we began: drivers that are non-deterministic
> will continue being deterministic regardless of what solution is adopted,
> if any, and will be in need of a re-write/major-modification, which
> itself will have little or no added value for non-rters ...

>From my memory DRM drivers have direct path to the vertical retrace
through the current ioctl() interface. It's not an issue for that driver
and probably many others that use simple syscalls like that.

The RT patch isn't hard to maintain and only one jerk-off objected to
it without providing any useful information why the single kernel
approach is faulty other than it jars his easily offended sensibilities

bill

