Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266128AbSLSUOQ>; Thu, 19 Dec 2002 15:14:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266161AbSLSUOP>; Thu, 19 Dec 2002 15:14:15 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:25780 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S266135AbSLSUOP>; Thu, 19 Dec 2002 15:14:15 -0500
Message-ID: <3E022AB0.4050409@gmx.net>
Date: Thu, 19 Dec 2002 21:23:12 +0100
From: Thomas Heinz <thomasheinz@gmx.net>
Reply-To: Thomas Heinz <thomasheinz@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010726 Netscape6/6.1
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: module_list not exported
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Just a short question. Why are module_list and modlist_lock not
exported as symbols in 2.4? If they were available it would be very
easy to realize some kind of module autoloading mechanism for example.
Just loading the module via request_module and afterwards getting the
corresponding struct module * by searching through module_list
(and of course incrementing use count).

It would be kind if you could cc to my private e-mail as I'm
currently not subscribed. Thank you.


Regards

Thomas

