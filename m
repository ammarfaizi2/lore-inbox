Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261261AbTEKLqo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 07:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbTEKLqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 07:46:44 -0400
Received: from host132.googgun.cust.cyberus.ca ([209.195.125.132]:51375 "EHLO
	marauder.googgun.com") by vger.kernel.org with ESMTP
	id S261261AbTEKLqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 07:46:43 -0400
Date: Sun, 11 May 2003 07:57:14 -0400 (EDT)
From: Ahmed Masud <masud@googgun.com>
To: Terje Malmedal <terje.malmedal@usit.uio.no>
Cc: <arjanv@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jesse Pollard <jesse@cats-chateau.net>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       "viro@parcelfarce.linux.theplanet.co.uk" 
	<viro@parcelfarce.linux.theplanet.co.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Terje Eggestad <terje.eggestad@scali.com>
Subject: Re: The disappearing sys_call_table export.
In-Reply-To: <E19EoaN-0000OJ-00@aqualene.uio.no>
Message-ID: <Pine.LNX.4.33.0305110756200.27901-100000@marauder.googgun.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 11 May 2003, Terje Malmedal wrote:

>
>
> just replace
>      return original_syscall(userfilename);
> with
>      return original_syscall(kernelpointer);

That's about right :) need to switch to kernel space with set_fs though
(see other messages in the thread). - A

