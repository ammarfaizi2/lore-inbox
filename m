Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263119AbTJPT20 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 15:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263129AbTJPT20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 15:28:26 -0400
Received: from ogi.bezeqint.net ([192.115.106.14]:13497 "EHLO ogi.bezeqint.net")
	by vger.kernel.org with ESMTP id S263119AbTJPT2Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 15:28:25 -0400
Message-ID: <3F8EF17A.2040502@users.sf.net>
Date: Thu, 16 Oct 2003 21:28:58 +0200
From: Eli Billauer <eli_billauer@users.sf.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en, he
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: David Mosberger-Tang <David.Mosberger@acm.org>
Subject: Re: [RFC] frandom - fast random generator module
References: <HbGf.8rL.1@gated-at.bofh.it> <HbQ5.ep.27@gated-at.bofh.it> <Hdyv.2Vd.13@gated-at.bofh.it> <HeE6.4Cc.1@gated-at.bofh.it> <HjaT.3nN.7@gated-at.bofh.it> <Hjkw.3Al.11@gated-at.bofh.it> <ugzng1axel.fsf@panda.mostang.com>
In-Reply-To: <ugzng1axel.fsf@panda.mostang.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allow me to supply a couple facts about frandom:

* It's not a "crappy" RNG. Its RC4 origins and the fact, that it has 
passed tests indicate the opposite. A fast RNG doesn't necessarily mean 
a bad one. I doubt if any test will tell the difference between frandom 
and any other good RNG. You're most welcome to try.

* Frandom is written completely in C. On an i686, gcc compiles the 
critical part to 26 assembly instructions per byte, and I doubt if any 
hand assembly would help significantly. The algorithms is clean and 
simple, and the compiler performs well with it.

   Eli

