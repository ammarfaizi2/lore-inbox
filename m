Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262051AbTJ0Nd2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 08:33:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262464AbTJ0Nd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 08:33:27 -0500
Received: from aeimail.aei.ca ([206.123.6.14]:65226 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S262051AbTJ0Nd0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 08:33:26 -0500
From: Ed Tomlinson <edt@aei.ca>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6t9 SATA slower than 2.4.20
Date: Mon, 27 Oct 2003 08:33:56 -0500
User-Agent: KMail/1.5.9
Cc: Shaun Savage <savages@savages.net>
References: <3F9D196C.9080301@savages.net>
In-Reply-To: <3F9D196C.9080301@savages.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200310270833.57182.edt@aei.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On October 27, 2003 08:11 am, Shaun Savage wrote:
> I have just compiled and installed kernel 2.6t9 on my RH9 / Asus A7N8X
> Deluxe.  I find the disk access is slower using the 2.6 kernel than the
> 2.4.20 kernel.
>
> To get it to work for 2.4.20 kernel I have to use
> # hdparm -d1 -X88 /dev/hde
> then the buffered disk read goes from 1.5M to 55M
>
> On the 2.6 kernel the buffered disk read is only 16M
>
> What do I have to do to increase the disk speed for kernel 2.6t9?

What happens with you really test?  ie. using programs (bonnie, iozone etc)
to test disk speed?  Is it still slower?  I think that hdparm does not tell the complete
story.

Ed Tomlinson
