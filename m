Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030518AbVIOQZG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030518AbVIOQZG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 12:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030517AbVIOQZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 12:25:06 -0400
Received: from xenotime.net ([66.160.160.81]:53696 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030518AbVIOQZF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 12:25:05 -0400
Date: Thu, 15 Sep 2005 09:25:02 -0700 (PDT)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Mark <marik@yandex.ru>
cc: linux-kernel@vger.kernel.org
Subject: Re: COMPILATION BUG
In-Reply-To: <43296031.000001.08694@tide.yandex.ru>
Message-ID: <Pine.LNX.4.58.0509150923220.1137@shark.he.net>
References: <43296031.000001.08694@tide.yandex.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Sep 2005, Mark wrote:

> PROBLEM: The kernel does not compile with my config and my versions.
> see attached file.

Please don't use zipped tarballs for bug reports.

{standard input}: Assembler messages:
{standard input}:840: Error: suffix or operands invalid for `mov'
{standard input}:841: Error: suffix or operands invalid for `mov'
{standard input}:935: Error: suffix or operands invalid for `mov'
{standard input}:936: Error: suffix or operands invalid for `mov'
{standard input}:986: Error: suffix or operands invalid for `mov'
{standard input}:987: Error: suffix or operands invalid for `mov'
{standard input}:989: Error: suffix or operands invalid for `mov'
{standard input}:1001: Error: suffix or operands invalid for `mov'

These are assembler ("as") error messages.
'as' is part of binutils.
It appears that you need to upgrade your binutils package.

-- 
~Randy
