Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262235AbVF2EUl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262235AbVF2EUl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 00:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262239AbVF2EUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 00:20:40 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:21387 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262235AbVF2EUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 00:20:36 -0400
To: Sreeni <sreeni.pulichi@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Memory management while loading program in Linux
References: <94e67edf05062810586d6141f3@mail.gmail.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 28 Jun 2005 22:20:27 -0600
In-Reply-To: <94e67edf05062810586d6141f3@mail.gmail.com> (sreeni.pulichi@gmail.com's
 message of "Tue, 28 Jun 2005 13:58:54 -0400")
Message-ID: <m1br5p3ib8.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sreeni <sreeni.pulichi@gmail.com> writes:

> Hello,
>
> I have a query regarding memory management using Linux kernel.
>
> In our system we have a secure physical memory starting and ending at
> predefined addresses. We want to execute certain programs, which have
> to be running secure in those address spaces only.
>
> Is it possible to force the loader to load the "particular" program
> (both the code and data segment) at that pre-defined secure physical
> memory, without any major kernel changes?

Sounds a little silly but in essence the loader is implemented
in user space so it shouldn't require any kernel changes.

Eric
