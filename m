Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262103AbUCRIrb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 03:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262077AbUCRIrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 03:47:31 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:3546 "EHLO
	myware.akkadia.org") by vger.kernel.org with ESMTP id S262103AbUCRIra
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 03:47:30 -0500
Message-ID: <4059621A.4040307@redhat.com>
Date: Thu, 18 Mar 2004 00:47:22 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040317
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: sched_setaffinity usability
References: <40595842.5070708@redhat.com> <20040318081249.GA26373@hockin.org> <40595C43.1040907@redhat.com>
In-Reply-To: <40595C43.1040907@redhat.com>
X-Enigmail-Version: 0.83.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replying to my own post.

Forget the proposed patch.  If we ever want to get the new interfaces
standardized saying the affinity mask is undefined after a failed
setaffinity call is not acceptable.

So I'm going to hardcode the fact that the value returned by a
successful getaffinity call will never change.  Regardless of how many
hotplug CPUs as added.  Can this be guaranteed?

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
