Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268111AbUIVXWJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268111AbUIVXWJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 19:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268115AbUIVXWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 19:22:09 -0400
Received: from peabody.ximian.com ([130.57.169.10]:24204 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S268111AbUIVXWG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 19:22:06 -0400
Subject: Re: [patch] inotify: locking
From: Robert Love <rml@novell.com>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1095895360.29226.17.camel@vertex>
References: <1095881861.5090.59.camel@betsy.boston.ximian.com>
	 <1095895360.29226.17.camel@vertex>
Content-Type: text/plain
Date: Wed, 22 Sep 2004 19:22:05 -0400
Message-Id: <1095895325.2454.135.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94.1 (1.5.94.1-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-22 at 19:22 -0400, John McCutchan wrote:

> Okay, this is my first kernel project so I didn't know/follow all of the
> rules, I admit it is a bit of a mishmash.

Heh, none of these issues were big, and everything else was fine.

> Yes, AFAIK the only places where we rely on the dev not going away are
> when we are handling a request from user space. As long as VFS
> operations are serialized I don't think we have to worry about that.

You can see what locks and serialization the VFS uses in
Documentation/filesystems/Locking

	Robert Love


