Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262415AbSK0MMJ>; Wed, 27 Nov 2002 07:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262414AbSK0MMI>; Wed, 27 Nov 2002 07:12:08 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:18450 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S262415AbSK0ML6>;
	Wed, 27 Nov 2002 07:11:58 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: A Kernel Configuration Tale of Woe 
In-reply-to: Your message of "Wed, 27 Nov 2002 13:03:23 BST."
             <Pine.LNX.4.44.0211271234560.2109-100000@serv> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 27 Nov 2002 23:19:00 +1100
Message-ID: <12497.1038399540@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Nov 2002 13:03:23 +0100 (CET), 
Roman Zippel <zippel@linux-m68k.org> wrote:
>On Wed, 27 Nov 2002, Keith Owens wrote:
>
>> cat > .force_default <<EOF
>> CONFIG_BLK_DEV_IDE=y
>> CONFIG_BLK_DEV_IDEDISK=y
>> EOF
>> make allmodconfig 
>> 
>> That used to work, until 2.5.48.  Being able to force selected options
>> and have the rest of the options default to all Y or all M was
>> extremely useful.  What a pity that Kconfig removed this facility.
>
>It's not that difficult to reimplement, but it was an undocumented 
>feature

Bullshit.  It was fully documented in kbuild 2.5.  Just because Kai
dropped the docs when he stole bits from kbuild 2.5 does not make
.force_default into an undocumented feature.

>so I'd rather concentrated on the rest and waited until one of a 
>few people who knew about this feature would complain.

People do not know about it because Kai dropped the docs.

