Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751572AbWHXPCK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751572AbWHXPCK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 11:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751567AbWHXPCK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 11:02:10 -0400
Received: from mail8.sea5.speakeasy.net ([69.17.117.10]:63684 "EHLO
	mail8.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751572AbWHXPCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 11:02:09 -0400
Date: Thu, 24 Aug 2006 11:02:07 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Eric Paris <eparis@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch 1/1] selinux: fix tty locking
In-Reply-To: <1156425192.8506.167.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Pine.LNX.4.64.0608241101510.13688@d.namei>
References: <1156425192.8506.167.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Aug 2006, Stephen Smalley wrote:

> Take tty_mutex when accessing ->signal->tty in selinux code.
> Noted by Alan Cox.  Longer term, we are looking at refactoring the code to provide better encapsulation of the tty layer, but this is a simple fix that addresses the immediate bug.
> 
> Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

Acked-by: James Morris <jmorris@namei.org>




-- 
James Morris
<jmorris@namei.org>
