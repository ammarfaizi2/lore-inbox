Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261713AbVA3Pj2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261713AbVA3Pj2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 10:39:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261714AbVA3Pj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 10:39:28 -0500
Received: from gate.firmix.at ([80.109.18.208]:41656 "EHLO gate.firmix.at")
	by vger.kernel.org with ESMTP id S261713AbVA3PjZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 10:39:25 -0500
Subject: Re: userspace vs. kernelspace address
From: Bernd Petrovitsch <bernd@firmix.at>
To: Rock Gordon <rockgordon@yahoo.com>
Cc: Jan Hudec <bulb@ucw.cz>, linux-kernel@vger.kernel.org,
       kernelnewbies@nl.linux.org
In-Reply-To: <20050128214051.34768.qmail@web41411.mail.yahoo.com>
References: <20050128214051.34768.qmail@web41411.mail.yahoo.com>
Content-Type: text/plain
Organization: http://www.firmix.at/
Date: Sun, 30 Jan 2005 16:37:54 +0100
Message-Id: <1107099474.9213.8.camel@gimli.at.home>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-01-28 at 13:40 -0800, Rock Gordon wrote:
> Lemme explain my problem a little bit more .... I have
> a thread that does exactly similar things in
> kernel-mode and user-mode (depending on how you
> invoked it; of course, the kernel one is forked using
> kernel_thread(), and the user one is from
> pthread_create()). The architecture-dependant stuff is
> taken care of by extensive use of __KERNEL__ macro
> testing.

You can than use the same macros for getting to correct copying
function.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services



