Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751023AbWHTRjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023AbWHTRjh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 13:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751024AbWHTRjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 13:39:37 -0400
Received: from relay02.pair.com ([209.68.5.16]:11528 "HELO relay02.pair.com")
	by vger.kernel.org with SMTP id S1751015AbWHTRjg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 13:39:36 -0400
X-pair-Authenticated: 71.197.50.189
From: Chase Venters <chase.venters@clientec.com>
To: "Irfan Habib" <irfan.habib@gmail.com>
Subject: Re: Where is pthreads implemented?
Date: Sun, 20 Aug 2006 12:39:11 -0500
User-Agent: KMail/1.9.4
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
References: <3420082f0608201035m2c45731biba0c2b095d3a2e86@mail.gmail.com>
In-Reply-To: <3420082f0608201035m2c45731biba0c2b095d3a2e86@mail.gmail.com>
Organization: Clientec, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608201239.34415.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 20 August 2006 12:35, Irfan Habib wrote:
> Hi,
>
> Where is pthreads implemented in a linux system? Is it in some user
> libraries or in the kernel?
>

You want the Native Posix Thread Library from glibc. The kernel's work is 
mostly via the clone() and futex() syscalls.

Thanks,
Chase
