Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318098AbSHBEGw>; Fri, 2 Aug 2002 00:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318095AbSHBEGw>; Fri, 2 Aug 2002 00:06:52 -0400
Received: from mail.webmaster.com ([216.152.64.131]:35216 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S318081AbSHBEGv> convert rfc822-to-8bit; Fri, 2 Aug 2002 00:06:51 -0400
From: David Schwartz <davids@webmaster.com>
To: <steve@primalhost.com>, <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.61 (1055) - Licensed Version
Date: Thu, 1 Aug 2002 21:10:18 -0700
In-Reply-To: <002401c239d6$14466ee0$1e2efea9@steveuyfdnjo6s>
Subject: Re: How to Imcrease FD Size
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <20020802041019.AAA3647@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 2 Aug 2002 13:38:27 +1000, Steve wrote:
>Hey,
>I was wondering how to increase the FD Size for users... Atm its set
>at 1024.. But i want to give user "xxx" FD Max size of 5120..
>
>Is This possible..

	This is not a kernel issue. The limit is raised and lowered by user 
programs. A version of 'login' that sets this limit prior to dropping 
privileges may be what you want. You can also do it with PAM.

	Check with people familiar with your distribution.

	DS


