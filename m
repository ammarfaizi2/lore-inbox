Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbTENTTG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 15:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261279AbTENTTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 15:19:06 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:5085 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S261244AbTENTTF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 15:19:05 -0400
Date: Wed, 14 May 2003 20:32:21 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Christopher Hoover <ch@murgatroid.com>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: [PATCH] 2.5.68 FUTEX support should be optional
Message-ID: <20030514193221.GA28385@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Ulrich Drepper <drepper@redhat.com>,
	Christopher Hoover <ch@murgatroid.com>,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com
References: <20030513213157.A1063@heavens.murgatroid.com> <20030514071446.A2647@infradead.org> <20030514005213.A3325@heavens.murgatroid.com> <3EC296CE.9050704@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EC296CE.9050704@redhat.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 14, 2003 at 12:19:42PM -0700, Ulrich Drepper wrote:

 > If this is what is wanted (and I don't really think it's useful is a MMU
 > is available) you should explain the consequences in the help text.
 > Basically, no current and future glibc version has the slightest chance
 > of working.

That seems to imply that the current glibc makes futexes mandatory,
which surely isn't the case or we'd not be able to run with 2.4 and earlier
kernels.

		Dave

