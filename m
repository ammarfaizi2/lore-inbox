Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263081AbVGIC2X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263081AbVGIC2X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 22:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263084AbVGIC2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 22:28:23 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:3978 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263081AbVGIC2W convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 22:28:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=SNwLbSOHEjrHFN6PDlkfEATrIlCVk1MGHz6QBCHb2KrqeGrgW6bMAsHGZLIVpdbVF1g9HYIE9M5GRnS/7pqwG3hpr8PUdo97BmJ2+SnKyaYb1zlQ6p1s1dTLUx9dSnP0ltFy1tW6aGRK6xPpLsUSlhk+a1jpA3lKhlIVLXjXJYU=
Message-ID: <96968b4e05070819286482937c@mail.gmail.com>
Date: Fri, 8 Jul 2005 22:28:20 -0400
From: u u <userstack@gmail.com>
Reply-To: u u <userstack@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.6.x.x Execution Process Question
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Im looking for some help on some research I am conducting. Im trying
to understand the complete execution process from start to finish of
an ELF executable object on the i386 platform in particular, but
x86_64 works as well. So far I have come up with the following:

Shell passes arguments and environment to execve() -> sys_execve() ->
do_execve() -> search_binary_handler() -> ?

Is this complete in a very generic way? What specifics happen along the way?

Most of the papers I have found on this are from older kernel versions
2.0 and 2.2. Im trying to find out the specifics of it all, for
example which registers are zeroed out before passing control to
userspace and where it happens. How does the stack look when control
is passed? These types of specifics are what I had in mind.

If anyone can point me in the right direction or provide an
explanation it would be helpful. Thank you.

-us
