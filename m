Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267740AbUHJVpe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267740AbUHJVpe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 17:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267759AbUHJVpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 17:45:24 -0400
Received: from quechua.inka.de ([193.197.184.2]:13784 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S267740AbUHJVnJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 17:43:09 -0400
From: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Bug zapper?  :)
Organization: Deban GNU/Linux Homesite
In-Reply-To: <4118E78F.8070301@comcast.net>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.5-20040615 ("Gighay") (UNIX) (Linux/2.6.5 (i686))
Message-Id: <E1BueOh-0006ij-00@calista.eckenfels.6bone.ka-ip.net>
Date: Tue, 10 Aug 2004 23:43:07 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <4118E78F.8070301@comcast.net> you wrote:
> I guess it should describe INPUT, OUTPUT, PROCESS, STATE CHANGE, and 
> ERRORS :/

You do not need to describe behaviour if the pre-condition is not valid. 
This is common asumption in "design by contract". However, this is not good
robust programming, to not handle those pre-condition violations.

> Readable.  Don't guess what the code does.

What else is the author of the comment doing? You cant describe all
(important) aspects of a piece of code in a language that is less complex
than the code itself (locking, concurrency, mm, ressouce consumption, ...).
In fact you are very likely introducing errors. Thats why comments are only
needed for navigating you and giving you the overall picture. They are also
good to explain unusual statements (especially in optimized hot path).

> Of course not.  The goal I was aiming for was to create an extremely 
> structured documentation scheme in the hopes that it would provide a 
> great deal of ease in understanding what a function does.  "if you don't 
> understand what it does, don't fuck with my code"

Well, actually it is good to describe a function at the high level, but dont
go further than that.

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
