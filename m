Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261473AbVGCQvw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261473AbVGCQvw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 12:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbVGCQvw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 12:51:52 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52157 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261473AbVGCQvk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 12:51:40 -0400
Date: Sun, 3 Jul 2005 12:51:20 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Kurt Garloff <garloff@suse.de>
cc: Linux kernel list <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       Greg Kroah-Hartman <gregkh@suse.de>, Steve Beattie <smb@wirex.com>
Subject: Re: [PATCH 3/3] Use conditional
In-Reply-To: <20050703154405.GE11093@tpkurt.garloff.de>
Message-ID: <Xine.LNX.4.44.0507031250290.30007-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Jul 2005, Kurt Garloff wrote:

> capablities is used. These are not called via indirect calls but 
> called as hardcoded calls and might thus be inlined; the price for
> this is a conditional -- benchmarks done by hp showed this to be
> beneficial (on ia64).

What about on i386, x86_64 or ppc64?


- James
-- 
James Morris
<jmorris@redhat.com>


