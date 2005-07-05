Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261894AbVGEQkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261894AbVGEQkV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 12:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbVGEP5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 11:57:14 -0400
Received: from mx1.redhat.com ([66.187.233.31]:38892 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261897AbVGEPky (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 11:40:54 -0400
Date: Tue, 5 Jul 2005 11:40:40 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Kurt Garloff <garloff@suse.de>
cc: Tony Jones <tonyj@immunix.com>,
       Linux kernel list <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       Greg Kroah-Hartman <gregkh@suse.de>, Steve Beattie <smb@wirex.com>,
       Linux LSM list <linux-security-module@wirex.com>
Subject: Re: [PATCH 1/3] Make cap default
In-Reply-To: <20050705072111.GA10453@tpkurt.garloff.de>
Message-ID: <Xine.LNX.4.44.0507051139470.3247-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jul 2005, Kurt Garloff wrote:

> #  define COND_SECURITY(seop, def)			\
> 	(security_opt->seop == NULL) ||			\
> 	 security_ops == &capability_security_ops)?	\
> 	 def: security_ops->seop

Why is this a macro and not a static inline?



- James
-- 
James Morris
<jmorris@redhat.com>


