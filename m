Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932288AbWIKSaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbWIKSaU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 14:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbWIKSaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 14:30:19 -0400
Received: from taganka54-host.corbina.net ([213.234.233.54]:32202 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S932288AbWIKSaS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 14:30:18 -0400
Date: Mon, 11 Sep 2006 22:29:56 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Jean Delvare <jdelvare@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, "Eric W. Biederman" <ebiederm@xmission.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] proc: bye bye tasklist_lock
Message-ID: <20060911182956.GA246@oleg>
References: <20060909221839.GA141@oleg> <200609111319.42132.jdelvare@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609111319.42132.jdelvare@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11, Jean Delvare wrote:
> Hi Oleg,
> 
> On Sunday 10 September 2006 00:18, Oleg Nesterov wrote:
> > fs/proc/ does not use tasklist_lock anymore.
> >
> > These patches are simple enough and do not depend on each other.
> > The only problem I don't know how to really test them.
> 
> Just to make sure I understand what it is all about: Is there a relation 
> between this patchset and the recent patch from Eric fixing the 
> readdir(/proc) race?

No, they are not related. This series doesn't fix bugs, just
removes tasklist_lock from fs/proc/ entirely.

Oleg.

