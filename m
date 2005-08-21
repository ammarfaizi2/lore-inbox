Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751191AbVHUWMS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbVHUWMS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 18:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbVHUWMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 18:12:18 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:21634 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751191AbVHUWMQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 18:12:16 -0400
To: =?iso-8859-1?q?Guillermo_L=F3pez_Alejos?= <glalejos@gmail.com>
Cc: Linh Dang <linhd@nortel.com>, linux-kernel@vger.kernel.org
Subject: Re: Environment variables inside the kernel?
References: <4fec73ca050818084467f04c31@mail.gmail.com>
	<m2ek8r5hhh.fsf@Douglas-McNaughts-Powerbook.local>
	<wn5slx75cjs.fsf@linhd-2.ca.nortel.com>
	<4fec73ca05081811488ec518e@mail.gmail.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 21 Aug 2005 16:12:02 -0600
In-Reply-To: <4fec73ca05081811488ec518e@mail.gmail.com> (
 =?iso-8859-1?q?Guillermo_L=F3pez_Alejos's_message_of?= "Thu, 18 Aug 2005
 20:48:04 +0200")
Message-ID: <m1fyt3ueh9.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guillermo López Alejos <glalejos@gmail.com> writes:

> Whoa!, I did not expect so many replies. Thank you for your answers.
>
> The thing is that the Computer Architecture area of the University I
> am studying at is developing a parallel filesystem. Currently it works
> as a stand-alone program (this is why it uses resources like
> environment variables), and I have been told to integrate it in the
> Linux kernel.

??
Usually when I hear stand-alone program I think of program that runs
without the need of a kernel.  You have an environment in that context?

> I have to justify changes on this filesystem code (like avoiding the
> use of environment variables) to my tutor. In this case I needed to
> find why it is not possible to use environment variables in kernel
> space.

Be very careful.  Generally I think at least until the filesystem
is very stable running your filesystem server in the kernel is a mistake.

And the concept of a parallel filesystem with just one server just
sounds wrong from any context.

Eric
