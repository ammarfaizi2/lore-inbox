Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265225AbTIDRY0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 13:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265228AbTIDRY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 13:24:26 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:43453 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S265225AbTIDRYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 13:24:23 -0400
X-Sender-Authentication: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Thu, 4 Sep 2003 19:24:21 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Compiling an i386 kernel on AMD Opteron
Message-Id: <20030904192421.5b176adf.skraw@ithnet.com>
In-Reply-To: <16215.4277.540644.262286@gargle.gargle.HOWL>
References: <20030904115209.56e019b1.skraw@ithnet.com>
	<16215.4277.540644.262286@gargle.gargle.HOWL>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Sep 2003 12:15:17 +0200
Mikael Pettersson <mikpe@csd.uu.se> wrote:

> Stephan von Krawczynski writes:
>  > Hello,
>  > 
>  > is it possible to compile a kernel on Opteron for i386 (32-bit) and not 64
>  > bit Opteron with usual make procedures?
>  > 
>  > When I do a simple "make menuconfig" I can only see the Opteron processor
>  > type in "Processor type and features" ...
> 
> You need to learn about cross-compilation.

Do you really call it cross-compilation if you are working on a 32-bit linux
(Opteron driven) and try to compile a new kernel for the very same box?

I guess it should indeed be possible to recognise that at least opterons are
able to support multiple platforms. That's why I think one should be able to
select them at menuconfig rather than via make options. Sure this processor is
somehow unique, on the other hand you are as well able to compile for 386 on a
P4. I know this is not really comparable but it points roughly in the same
direction...

Regards,
Stephan
