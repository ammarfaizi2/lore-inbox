Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932067AbVKJQpK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbVKJQpK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 11:45:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932066AbVKJQpK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 11:45:10 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:5517 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751160AbVKJQpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 11:45:04 -0500
Subject: Re: [PATCH] poll(2) timeout values
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Peter Staubach <staubach@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <437375DE.1070603@redhat.com>
References: <437375DE.1070603@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 10 Nov 2005 17:15:56 +0000
Message-Id: <1131642956.20099.39.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-11-10 at 11:31 -0500, Peter Staubach wrote:
> Clearly, the timeout calculations problem can be fixed without changing
> the arguments to the sys_poll() routine.  However, it is cleaner to fix
> it this way by ensuring the sizes and types of arguments match.

There really is no need for the kernel API to match the userspace one,
many of our others differ between the syscall interface which is most
definitely 'exported' in one sense and the POSIX interface which is
defined by libc, posix and the LSB etc

No argument about the timeout fix.

Alan

