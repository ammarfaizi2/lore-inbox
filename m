Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264193AbTDJVbk (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 17:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264195AbTDJVbk (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 17:31:40 -0400
Received: from mario.gams.at ([194.42.96.10]:44315 "EHLO mario.gams.at")
	by vger.kernel.org with ESMTP id S264193AbTDJVbh convert rfc822-to-8bit (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 17:31:37 -0400
X-Mailer: exmh version 2.6.1 18/02/2003 with nmh-1.0.4
From: Bernd Petrovitsch <bernd@gams.at>
To: Chuck Ebbert <76306.1226@compuserve.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: kernel support for non-english user messages 
References: <200304101658_MC3-1-33DE-AB9F@compuserve.com> 
In-reply-to: Your message of "Thu, 10 Apr 2003 16:54:53 EDT."
             <200304101658_MC3-1-33DE-AB9F@compuserve.com> 
X-url: http://www.luga.at/~bernd/
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Date: Thu, 10 Apr 2003 23:08:17 +0200
Message-ID: <11196.1050008897@frodo.gams.co.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert <76306.1226@compuserve.com> wrote:
>>>      How about changing the way printk works, so that instead of
>>> combining the format string, it just "prints" its args:
>>> 
>>> printk("%s: name %p is %d\n", name, ptr, val);
>>> 
>>> results in the following in the kernel buffer:
>>> 
>>> "%s: name %p is %d\n", "stringval", 0x4790243, 44
[...]
> The real problem I see is that this approach doesn't make it any
>easier to translate the messages.

If you habe the above, you could use/copy/reuse gettext() since the 
format string is used a key/hash/unique id for the translation.

	Bernd
-- 
Bernd Petrovitsch                              Email : bernd@gams.at
g.a.m.s gmbh                                  Fax : +43 1 205255-900
Prinz-Eugen-Straﬂe 8                    A-1040 Vienna/Austria/Europe
                     LUGA : http://www.luga.at


