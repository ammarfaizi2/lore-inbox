Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265042AbUD3Chq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265042AbUD3Chq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 22:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265043AbUD3Chp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 22:37:45 -0400
Received: from vena.lwn.net ([206.168.112.25]:20182 "HELO lwn.net")
	by vger.kernel.org with SMTP id S265042AbUD3Cho (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 22:37:44 -0400
Message-ID: <20040430023742.1842.qmail@lwn.net>
To: Chris Mason <mason@suse.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc[23] boot failure on x86_64 
From: corbet@lwn.net (Jonathan Corbet)
In-reply-to: Your message of "Thu, 29 Apr 2004 13:45:14 EDT."
             <1083260713.30344.291.camel@watt.suse.com> 
Date: Thu, 29 Apr 2004 20:37:42 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Could you try reversing this one:
> Name: Fix cpumask iterator over empty cpu set

As I feared, reverting that patch didn't fix the problem.  It is also
present in 2.6.6-rc1, so the regression happened somewhere between 2.6.5
and there.  That still leaves a lot of patches to sift through.

Sigh.

jon

Jonathan Corbet
Executive editor, LWN.net
corbet@lwn.net
