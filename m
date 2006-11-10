Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932823AbWKJJ6u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932823AbWKJJ6u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 04:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932826AbWKJJ6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 04:58:50 -0500
Received: from cantor.suse.de ([195.135.220.2]:7657 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932823AbWKJJ6t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 04:58:49 -0500
From: Andi Kleen <ak@suse.de>
To: "Aaron Durbin" <adurbin@google.com>
Subject: Re: [PATCH] x86_64: Fix partial page check to ensure unusable memory is not being marked usable.
Date: Fri, 10 Nov 2006 10:58:41 +0100
User-Agent: KMail/1.9.5
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Mel Gorman" <mel@csn.ul.ie>, "Andrew Morton" <akpm@osdl.org>
References: <8f95bb250611091327j14cc96adwf66c0ed0ecf3b8ba@mail.gmail.com>
In-Reply-To: <8f95bb250611091327j14cc96adwf66c0ed0ecf3b8ba@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611101058.41621.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 09 November 2006 22:27, Aaron Durbin wrote:
> Fix partial page check in e820_register_active_regions to ensure
> partial pages are
> not being marked as active in the memory pool.

Added thanks.

Critical fix for .19 i guess

-Andi
