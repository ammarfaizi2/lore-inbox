Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266048AbUHARYR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266048AbUHARYR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 13:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266065AbUHARYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 13:24:17 -0400
Received: from quechua.inka.de ([193.197.184.2]:6573 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S266048AbUHARYP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 13:24:15 -0400
From: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: secure computing for 2.6.7
Organization: Deban GNU/Linux Homesite
In-Reply-To: <20040801155128.GG6295@dualathlon.random>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.5-20040615 ("Gighay") (UNIX) (Linux/2.6.5 (i686))
Message-Id: <E1BrK4C-0006d2-00@calista.eckenfels.6bone.ka-ip.net>
Date: Sun, 01 Aug 2004 19:24:12 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20040801155128.GG6295@dualathlon.random> you wrote:
>> where this has applied fix 3501 in the 2.6 branch and 123 according to
>> vendor MM, so you do not need to understand vendors XXX schema. However I am
> 
> if all vendors uses different numbers (i.e. vendor MM.123) then I can as
> well build the ugly database in function of the `uname -r`
> vendorization, building a database of uname -r or a database of
> MM/linux-26/whatever isn't going to be any different.

This is not about different vendors certifying the same level. Mainstream
software will always require a general fix-level, however internal software
may require some other hardening/configuration. Distributions and even end
users could use that string to certify "this build is compliant to
requirement level 123"

But I agree, it might be overkill for the utsname, however I feel leaving
that out of a secure level syscall may be underkill .)

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
