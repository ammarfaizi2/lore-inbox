Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262138AbVDFCiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbVDFCiN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 22:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262136AbVDFCiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 22:38:13 -0400
Received: from mail58-s.fg.online.no ([148.122.161.58]:14025 "EHLO
	mail58-s.fg.online.no") by vger.kernel.org with ESMTP
	id S262263AbVDFChz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 22:37:55 -0400
From: Kenneth =?iso-8859-1?q?Aafl=F8y?= <lists@kenneth.aafloy.net>
To: Matt Mackall <mpm@selenic.com>
Subject: Re: Coding style: mixed-case
Date: Wed, 6 Apr 2005 04:37:40 +0200
User-Agent: KMail/1.8
References: <200504060329.21469.lists@kenneth.aafloy.net> <20050406020929.GJ25554@waste.org>
In-Reply-To: <20050406020929.GJ25554@waste.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504060437.40256.lists@kenneth.aafloy.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 April 2005 04:09, Matt Mackall wrote:
> While there may be reasons why mixed case is suboptimal, the real
> reason is that it's hard to keep track of which style is used where.
> It's annoying and error-prone to have to remember the naming format
> for everything in addition to its name. As most things are in a
> standard style, things are made easier by having every piece of new
> code follow that style and let us slowly approach uniformity.

My primary concern was that of; why does the kernels own coding style
deviate from that advise given in it's documentation. Other than that
most mixed-case errors will be caught by the compiler, unless there
is an ambiguity with other mixed-case statements; which is probably
why that clause exists in the coding style documentation.

> If you posted a patch for pf_locked() and friends (and note that it's
> lowercase to match function-like usage), you'd probably find some
> enthusiasts and some naysayers. Most of the naysayers would object on
> the grounds of "it ain't broke", but if someone were to do it as part
> of a series of more substantial clean-ups, it'd likely be accepted.

Certainly I would like to have a go at a patch, but I must say that I do not
feel particularly familiar with the code in question to make such a change.
I would have risen to the challenge had this been a driver level change,
but the mmu is something that I will not touch untill I feel comfortable.
I feel that this is a change that would be best managed by an experienced
kernel janitor.

Kenneth
