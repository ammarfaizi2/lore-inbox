Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130129AbQKIFWV>; Thu, 9 Nov 2000 00:22:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130180AbQKIFWM>; Thu, 9 Nov 2000 00:22:12 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:19762 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S130129AbQKIFV7>; Thu, 9 Nov 2000 00:21:59 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Rusty Russell <rusty@linuxcare.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: Persistent module storage - modutils design 
In-Reply-To: Your message of "Thu, 09 Nov 2000 15:52:47 +1100."
             <20001109045247.BE39A8120@halfway.linuxcare.com.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 09 Nov 2000 16:21:17 +1100
Message-ID: <4925.973747277@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Nov 2000 15:52:47 +1100, 
Rusty Russell <rusty@linuxcare.com.au> wrote:
>In message <14032.973605093@ocs3.ocs-net> you write:
>> Looks like persistent data has to be stored in /lib/modules/persist (no
>> <version>, see earlier mail).
>
>You need versions: binary data is too prone to change (proven kernel
>history).  It's the kernel installer's duty to know which ones can be
>safely linked/copied to the new version.

Not saving persistent data in binary format, so no problem.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
