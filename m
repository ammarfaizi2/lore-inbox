Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264842AbSLMPEQ>; Fri, 13 Dec 2002 10:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264848AbSLMPEQ>; Fri, 13 Dec 2002 10:04:16 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:21149 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S264842AbSLMPEP> convert rfc822-to-8bit; Fri, 13 Dec 2002 10:04:15 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Symlink indirection
Date: Fri, 13 Dec 2002 16:11:25 +0100
User-Agent: KMail/1.4.3
References: <3DF9F780.1070300@walrond.org>
In-Reply-To: <3DF9F780.1070300@walrond.org>
Organization: WOLK - Working Overloaded Linux Kernel
Cc: Andrew Walrond <andrew@walrond.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212131611.04355.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 December 2002 16:06, Andrew Walrond wrote:

Hi Andrew,

> Is the number of allowed levels of symlink indirection (if that is the
> right phrase; I mean symlink -> symlink -> ... -> file) dependant on the
> kernel, or libc ? Where is it defined, and can it be changed?

fs/namei.c

 if (current->link_count >= 5)

change to a higher value.

So, the answer is: Kernel :)

ciao, Marc
