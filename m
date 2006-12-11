Return-Path: <linux-kernel-owner+w=401wt.eu-S1762425AbWLKEtO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762425AbWLKEtO (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 23:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762430AbWLKEtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 23:49:13 -0500
Received: from liaag2aa.mx.compuserve.com ([149.174.40.154]:36553 "EHLO
	liaag2aa.mx.compuserve.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762445AbWLKEtK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 23:49:10 -0500
Date: Sun, 10 Dec 2006 23:46:45 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Linux portability bugs
To: mariusn <mariusn@gmail.com>
Cc: linux-kernel@vger.kernel.org
Message-ID: <200612102347_MC3-1-D49B-AB99@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <a2705a960612012239j697f2799t27bec643f33c9e12@mail.gmail.com>

On Fri, 1 Dec 2006 22:39:01 -0800, mariusn wrote:

> I am a graduate student at University of Washington, building a tool
> automatically discover portability bugs in system-level code written
> in C. My definition of "portability" is at the data layout level,
> accounting for differences in alignment, padding, and generally layout
> policies on various platforms. E.g., one might perform a pointer cast
> that only works as intended when doubles are 4-byte aligned, which is
> the case with gcc/ia-32 (default options) but not with gcc/sparc (due
> to sparc's limited support for accessing doubles on non-8-byte
> boundaries).
> 
> I am looking for advice on how/where to look for these kinds of bugs
> in the kernel and related software. This (dated) document
> (http://netwinder.osuosl.org/users/b/brianbr/public_html/alignment.html
> ) describes exactly these sorts of issues in the context of Linux/ARM
> and mentions things like the kernel, binutils, cpio, X11, Orbit, as
> sources of these sorts of bugs. I am having a bit of a hard time
> locating change logs and otherwise related information on where these
> bugs occurred, patches that addressed them, etc.

Look for "compat" in the patch title and comments, like this one:

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=46c5ea3c9ae7fbc6e52a13c92e59d4fc7f4ca80a
-- 
Chuck
"Even supernovas have their duller moments."

