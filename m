Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932441AbWAIFzu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932441AbWAIFzu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 00:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932495AbWAIFzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 00:55:50 -0500
Received: from science.horizon.com ([192.35.100.1]:26163 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S932218AbWAIFzt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 00:55:49 -0500
Date: 9 Jan 2006 00:55:42 -0500
Message-ID: <20060109055542.20320.qmail@science.horizon.com>
From: linux@horizon.com
To: ltuikov@yahoo.com
Subject: Re: git pull on Linux/ACPI release tree
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And lastly, is there a tool whereby I can "see" changes
> between repos, kind of like git-diff but being able to
> give URLs too?

Write it yourself.  It's git-fetch + git-diff.

Or, put another way, if you think you need a special tool for working
with a remote repository, you don't understand git-fetch.

Since git history is immutable, there is no difference between a remote
copy and a local copy.  And since fetching is harmless to your local
repository, there's no problem.

If you don't want to copy the entire history, just fetch the tree rather
than the commit.  (Does git-fetch do that?  It's a subset of its current
effects, so would be an easy enough extension.)
