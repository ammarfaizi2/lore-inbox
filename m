Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261721AbSLJOc4>; Tue, 10 Dec 2002 09:32:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261836AbSLJOc4>; Tue, 10 Dec 2002 09:32:56 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:8205 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S261721AbSLJOcz>;
	Tue, 10 Dec 2002 09:32:55 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] compatibility syscall layer (lets try again) 
In-reply-to: Your message of "Mon, 09 Dec 2002 18:56:30 BST."
             <OFD8A28E03.33C21720-ONC1256C8A.00616515@de.ibm.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 11 Dec 2002 01:40:25 +1100
Message-ID: <28584.1039531225@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Dec 2002 18:56:30 +0100, 
"Martin Schwidefsky" <schwidefsky@de.ibm.com> wrote:
>
>> Well, that is tricky independently of the actual argument stuff - even
>the
>> _current_ system call restart ends up being tricky for you in that case,
>I
>> suspect. The current one already basically depends on rewriting the
>system
>> call number, it just leaves the arguments untouched.
>
>The current system call restart doesn't change the system call number. We just
>substract two from the psw address (aka eip) and go back to user space.

  EX R1,syscall - instruction length is 4, not 2.

