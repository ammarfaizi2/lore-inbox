Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261974AbUBNVHx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 16:07:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263370AbUBNVHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 16:07:53 -0500
Received: from relay.pair.com ([209.68.1.20]:45326 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S261974AbUBNVHv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 16:07:51 -0500
X-pair-Authenticated: 24.126.73.164
Message-ID: <402E8D1A.4000106@kegel.com>
Date: Sat, 14 Feb 2004 13:03:22 -0800
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en, de-de
MIME-Version: 1.0
To: Herbert Poetzl <herbert@13thfloor.at>, linux-kernel@vger.kernel.org
Subject: re: Kernel Cross Compiling
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl <herbert@13thfloor.at> wrote:
> I'm currently investigating the requirements/doability
> of a kernel cross compiling test bed/setup, able to do
> automated kernel builds for different architecture,
> just to see if it compiles and later to verify if a 
> given patch breaks that compile on any of the tested
> archs ...

Great idea!

>  I decided to use binutils 2.14.90.0.8, and gcc 3.3.2,
>    but soon discovered that gcc-3.3.2 will not be able 
>    to build a cross compiler for some archs like the
>    alpha, ia64, powerpc and even i386 ;) without some
>    modifications[2] but with some help, I got all headers
>    fixed, except for the ia64, which still doesn't work

Wouldn't it be easier to use http://kegel.com/crosstool
which already builds good toolchains for just about every
CPU type?
- Dan

-- 
US citizens: if you're considering voting for Bush, look at these first:
http://www.misleader.org/
http://www.cbc.ca/news/background/arar/
http://www.house.gov/reform/min/politicsandscience/
