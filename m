Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265468AbUAPNqT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 08:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265471AbUAPNqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 08:46:18 -0500
Received: from mail.aei.ca ([206.123.6.14]:53988 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S265468AbUAPNpr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 08:45:47 -0500
From: Ed Tomlinson <edt@aei.ca>
Organization: me
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.1-mm4
Date: Fri, 16 Jan 2004 08:45:16 -0500
User-Agent: KMail/1.5.93
Cc: Andrew Morton <akpm@osdl.org>
References: <20040115225948.6b994a48.akpm@osdl.org>
In-Reply-To: <20040115225948.6b994a48.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200401160845.17199.edt@aei.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 16, 2004 01:59 am, Andrew Morton wrote:
> - There's a patch here which changes the ia32 CPU type selection.  Make
>   sure you go in there and select the right CPU type(s), else the kernel
>   won't compile.   We might need to set a default here.
>
> - Kernel NFS server update
>
> - MD update
>
> - V4L update
>
> - A string of fixes against the parport, paride and associated drivers
>
> - Update to the latest UML
>
> - Patches to support gcc-3.4 on ia32.  There is more to do here - more
>   warnings need to be fixed and the exception tables need to be sorted.  I
>   didn't add the `-Winline' patch because it's way too noisy at present.

Hi Andrew,

Doing a modules install with mm4 gets a nfsd.ko needs unknown symbol dnotify_parent

Ideas?
Ed Tomlinson
