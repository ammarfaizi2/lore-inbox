Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751310AbVKJHu0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbVKJHu0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 02:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbVKJHu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 02:50:26 -0500
Received: from mx1.redhat.com ([66.187.233.31]:63699 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751310AbVKJHu0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 02:50:26 -0500
Message-ID: <4372FB65.1030309@redhat.com>
Date: Wed, 09 Nov 2005 23:48:53 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mail/News 1.5 (X11/20051105)
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: openat()
References: <43724AB3.40309@redhat.com> <Pine.LNX.4.63.0511091338200.728@twinlark.arctic.org> <4372F95E.3070107@pobox.com>
In-Reply-To: <4372F95E.3070107@pobox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> I'm interested in openat(2) for the race-free implications.

Given the limitation that only directory descriptors can be used without 
the O_XATTR flag I've already added openat to glibc.  It has no O_XATTR 
support but I don't consider this important.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
