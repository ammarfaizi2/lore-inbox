Return-Path: <linux-kernel-owner+willy=40w.ods.org-S781463AbUKBG1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S781463AbUKBG1i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 01:27:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S324735AbUKBG1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 01:27:37 -0500
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:34474 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S324767AbUKBG1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 01:27:32 -0500
Message-ID: <418728CA.1090707@yahoo.com.au>
Date: Tue, 02 Nov 2004 17:27:22 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: =?UTF-8?B?UGF3ZcWCIFNpa29yYQ==?= <pluto@pld-linux.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [oops] lib/vsprintf.c
References: <200411020719.55570.pluto@pld-linux.org>
In-Reply-To: <200411020719.55570.pluto@pld-linux.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paweł Sikora wrote:
> Hi,
> 
> vsprintf.c-      case 's':
> vsprintf.c-                    s = va_arg(args, char *);
> vsprintf.c-                    if ((unsigned long)s < PAGE_SIZE)
> vsprintf.c-                           s = "<NULL>";
> vsprintf.c-
> vsprintf.c:      OOPS!  =>     len = strnlen(s, precision);
> 

But it is the kernel module that's buggy. What's the problem?
