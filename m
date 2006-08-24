Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751529AbWHXNrZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751529AbWHXNrZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 09:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751532AbWHXNrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 09:47:25 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:60122 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751523AbWHXNrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 09:47:25 -0400
Subject: Re: [patch 1/1] selinux: fix tty locking
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Eric Paris <eparis@redhat.com>, James Morris <jmorris@namei.org>
In-Reply-To: <1156425192.8506.167.camel@moss-spartans.epoch.ncsc.mil>
References: <1156425192.8506.167.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 24 Aug 2006 15:08:29 +0100
Message-Id: <1156428509.3007.142.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-08-24 am 09:13 -0400, ysgrifennodd Stephen Smalley:
> Take tty_mutex when accessing ->signal->tty in selinux code.
> Noted by Alan Cox.  Longer term, we are looking at refactoring the code to provide better encapsulation of the tty layer, but this is a simple fix that addresses the immediate bug.
> 
> Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

Acked-by: Alan Cox <alan@redhat.com>

