Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276867AbRJCFB2>; Wed, 3 Oct 2001 01:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276866AbRJCFBS>; Wed, 3 Oct 2001 01:01:18 -0400
Received: from mail.webmaster.com ([216.152.64.131]:38072 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S275624AbRJCFBP> convert rfc822-to-8bit; Wed, 3 Oct 2001 01:01:15 -0400
From: David Schwartz <davids@webmaster.com>
To: <dwmw2@infradead.org>, MOHAMMED AZAD <mohammedazad@nestec.net>
CC: Linux-Kernel (E-mail) <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.51 (988) - Registered Version
Date: Tue, 2 Oct 2001 22:01:41 -0700
In-Reply-To: <3458.1002015803@redhat.com>
Subject: Re: Getting system time in kernel..
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <20011003050142.AAA10921@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 02 Oct 2001 10:43:23 +0100, David Woodhouse wrote:

>mohammedazad@nestec.net said:

>> Any idea how to get the system time in a kernel module.... I tried  this
>>in solaris... but i am getting only the GMT (that too elapsed  time) how do
>>i convert this to my locale time....  

>You can't. You shouldn't need to convert to localtime inside the kernel.
>What, precisely, are you trying to achieve?

	As an example, a filesystem might internally store local times in its 
inodes. You may not be free to change the on-disk format.

	DS


