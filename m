Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932580AbWJFUXD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932580AbWJFUXD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 16:23:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932581AbWJFUXD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 16:23:03 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8643 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932580AbWJFUXB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 16:23:01 -0400
Date: Fri, 6 Oct 2006 13:22:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: Vadim Lobanov <vlobanov@speakeasy.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] fdtable: Extensive fs/file.c cleanups.
Message-Id: <20061006132258.39fc58ed.akpm@osdl.org>
In-Reply-To: <200610052152.29013.vlobanov@speakeasy.net>
References: <200610052152.29013.vlobanov@speakeasy.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Oct 2006 21:52:28 -0700
Vadim Lobanov <vlobanov@speakeasy.net> wrote:

> As long as the previous patch replaces the guts of fs/file.c, it makes sense
> to tidy up all the code within. This work includes:
> 	code simplification via refactoring,
> 	elimination of unnecessary code paths,
> 	extensive commenting throughout the entire file, and
> 	other minor cleanups and consistency tweaks.
> This patch does not contain any functional modifications.
> 
> This is the last patch in the series. All the code should now be sparkly
> clean.

This (wordwrapped) patch should have been the first in the series, not the
last.  Having the substantive changes come after the cleanups makes
subsequent problem diagnosis simpler, means we have less code to revert if
it goes bad, etc.

So I'll drop this one.
