Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276879AbRJCGbB>; Wed, 3 Oct 2001 02:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276878AbRJCGaw>; Wed, 3 Oct 2001 02:30:52 -0400
Received: from mail.webmaster.com ([216.152.64.131]:31674 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S276876AbRJCGan> convert rfc822-to-8bit; Wed, 3 Oct 2001 02:30:43 -0400
From: David Schwartz <davids@webmaster.com>
To: <kaos@ocs.com.au>
CC: Linux-Kernel (E-mail) <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.51 (988) - Registered Version
Date: Tue, 2 Oct 2001 23:31:09 -0700
In-Reply-To: <31512.1002085772@kao2.melbourne.sgi.com>
Subject: Re: Getting system time in kernel..
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <20011003063110.AAA11976@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 03 Oct 2001 15:09:32 +1000, Keith Owens wrote:
>On Tue, 2 Oct 2001 22:01:41 -0700,
>David Schwartz <davids@webmaster.com> wrote:

>>    As an example, a filesystem might internally store local times in its
>>inodes. You may not be free to change the on-disk format.

>Whose local time?  The local time where the machine is or the local time of
>the user accessing the machine from the other side of the world?  There is a
>very good reason why timestamps are GMT (UTC).

	Well that's an argument in favor of two things:

	1) Avoiding such situations whenever possible by using UTC timestamps in 
things like filesystems, and

	2) Making local time offsets tuneable for each case where you need one. The 
physical location of the machine might or might not be meaningful.

	DS




