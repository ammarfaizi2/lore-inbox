Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751926AbWI1UIt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751926AbWI1UIt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 16:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751990AbWI1UIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 16:08:49 -0400
Received: from mail3.sea5.speakeasy.net ([69.17.117.5]:15577 "EHLO
	mail3.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751926AbWI1UIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 16:08:48 -0400
Date: Thu, 28 Sep 2006 16:08:47 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
       Cory Olmo <colmo@TrustedCS.com>
Subject: Re: [PATCH] SELinux - support mls categories for context mounts
In-Reply-To: <20060928124539.71aa5ee8.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0609281559500.28120@d.namei>
References: <Pine.LNX.4.64.0609281529140.28065@d.namei>
 <20060928124539.71aa5ee8.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Sep 2006, Andrew Morton wrote:

> > The proposed solution is to allow/require the SELinux context option 
> > specified to mount to use quotes when the context contains a comma.
> 
> None of this seems to be documented anywhere.  I expect the people who
> actually work on this stuff make a pretty tight group, but...

Context mounts have been covered in magazines and blogs, and other docs, 
e.g.

http://www.linuxjournal.com/node/7426/print

Category labels:
http://james-morris.livejournal.com/5583.html
http://james-morris.livejournal.com/8228.html
http://selinux-symposium.org/2006/slides/08-mcs.pdf

MLS & SELinux:
http://james-morris.livejournal.com/5020.html

Also see mount(8) under OPTIONS.


Please suggest any further documentation which you'd like to see.



- James
-- 
James Morris
<jmorris@namei.org>
