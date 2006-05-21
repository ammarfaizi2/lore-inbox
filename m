Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964892AbWEUXUr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964892AbWEUXUr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 19:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751547AbWEUXUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 19:20:47 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:34775 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751422AbWEUXUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 19:20:47 -0400
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, Herbert Poetzl <herbert@13thfloor.at>,
       serue@us.ibm.com, linux-kernel@vger.kernel.org, dev@sw.ru,
       devel@openvz.org, sam@vilain.net, xemul@sw.ru, haveblue@us.ibm.com,
       clg@fr.ibm.com
Subject: Re: [PATCH 0/9] namespaces: Introduction
References: <20060518154700.GA28344@sergelap.austin.ibm.com>
	<20060518103430.080e3523.akpm@osdl.org>
	<20060519124235.GA32304@MAIL.13thfloor.at>
	<20060519081334.06ce452d.akpm@osdl.org>
	<20060521225735.GA9048@elf.ucw.cz>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 21 May 2006 17:18:50 -0600
In-Reply-To: <20060521225735.GA9048@elf.ucw.cz> (Pavel Machek's message of
 "Mon, 22 May 2006 00:57:37 +0200")
Message-ID: <m1ejynnezp.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> writes:

> Well, if pid #1 virtualization is only needed for pstree, we may want
> to fix pstree instead :-).

One thing that is not clear is if isolation by permission checks is any
easier to implement than isolation with a namespace.

Isolation at permission checks may actually be more expensive in terms
of execution time, and maintenance.

Eric
