Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293150AbSCEBoK>; Mon, 4 Mar 2002 20:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293252AbSCEBoC>; Mon, 4 Mar 2002 20:44:02 -0500
Received: from zero.tech9.net ([209.61.188.187]:30483 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S293150AbSCEBnu>;
	Mon, 4 Mar 2002 20:43:50 -0500
Subject: Re: [PATCH] 2.5: preemptive kernel on UP
From: Robert Love <rml@tech9.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <E16i4AT-0001Rq-00@the-village.bc.nu>
In-Reply-To: <E16i4AT-0001Rq-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 04 Mar 2002 20:43:50 -0500
Message-Id: <1015292630.882.78.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-03-04 at 20:55, Alan Cox wrote:

> try
> 
> #if defined(a) || defined(b)

Is that needed since the .config is defined to 1 and 0 in autoconf.h?

> Interesting that the difference pre-empt makes is so large you didnt notice
> you hadn't re-enabled it ;)

The above fix isn't needed for i386 ... and I noticed the problem in the
first place because performance was odd.

	Robert Love

