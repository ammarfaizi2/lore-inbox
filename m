Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263223AbTIASDr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 14:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263224AbTIASDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 14:03:47 -0400
Received: from fw.osdl.org ([65.172.181.6]:18376 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263223AbTIASDq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 14:03:46 -0400
Message-ID: <33241.4.4.25.4.1062439418.squirrel@www.osdl.org>
Date: Mon, 1 Sep 2003 11:03:38 -0700 (PDT)
Subject: Re: Bug in vsprintf.c - vsscanf()
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <ramit.bhalla@wipro.com>
In-Reply-To: <52C85426D39B314381D76DDD480EEE0CFC6983@blr-m3-msg.wipro.com>
References: <52C85426D39B314381D76DDD480EEE0CFC6983@blr-m3-msg.wipro.com>
X-Priority: 3
Importance: Normal
Cc: <linux-kernel@vger.kernel.org>, <alan@redhat.com>
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
>
> There appears to be a bug in vsprintf.c
> The function vsscanf (if I'm correct) is the kernel mode equivalent of user
> mode sscanf. If one tries to read a hex string using the format "%x" it
> returns an error if the read buffer contains any character other than 0-9.
>
> I believe the culprit lies on line 640 of vsprintf.c
>
> It should be "isxdigit" instead of "isdigit".
>
> Hope I'm not missing anything here :)

Like what kernel version...?

If it's 2.4.x, is it recent?

~Randy




