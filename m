Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262164AbTFFSXv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 14:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262165AbTFFSXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 14:23:51 -0400
Received: from wmail.atlantic.net ([209.208.0.84]:8114 "HELO
	wmail.atlantic.net") by vger.kernel.org with SMTP id S262164AbTFFSXu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 14:23:50 -0400
Message-ID: <3EE0E227.7080107@techsource.com>
Date: Fri, 06 Jun 2003 14:49:11 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel printk format string compression: C syntax problem
References: <3EE0CF07.2070908@techsource.com> <Pine.LNX.4.53.0306061330520.7633@chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Richard B. Johnson wrote:

> 
> Aren't octal values supposed to always start with '0'? I remember
> this from some formal training when 'C' replaced Pascal. The
> second "printf()" should __not__ TAB over the text. With GNU
> gcc, it does. This doesn't mean that it's "correct", only that
> GNU does it that way.
> 

Octal values start with '0' when they're numerical values.  When they're 
in strings as escape characters, the C syntax is "\nnn".  Every 
reference I find says that.  Some script languages, however require that 
octal values start with '0' in strings, so csh would expect to see "\0nnn".

Additionally, when I compile in the dictionary into the program that
does the string replacement, I get no complaints, although every
character in there is "\nnn".

