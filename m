Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261951AbUEJWDl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261951AbUEJWDl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 18:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbUEJWBb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 18:01:31 -0400
Received: from smtpq2.home.nl ([213.51.128.197]:64710 "EHLO smtpq2.home.nl")
	by vger.kernel.org with ESMTP id S261987AbUEJWBJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 18:01:09 -0400
Message-ID: <409FFB44.5030304@keyaccess.nl>
Date: Mon, 10 May 2004 23:59:32 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040117
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: Linux 2.6.6 "IDE cache-flush at shutdown fixes"
References: <409F4944.4090501@keyaccess.nl> <200405102125.51947.bzolnier@elka.pw.edu.pl> <409FF068.30902@keyaccess.nl>
In-Reply-To: <409FF068.30902@keyaccess.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rene Herman wrote:

> With this one, the cache flushing noise is no more, but still a problem 
> unfortunately. With or without these patches, 2.6.6 powers down the 
> drive during reboot. This is very annoying, seeing as how it immediately 
> needs to spin up again for POST.

Sorry, mistaken. This only happens _with_ your change. Without, 2.6.6 
just complains.

Rene.
