Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261655AbVBWWvZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261655AbVBWWvZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 17:51:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbVBWWs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 17:48:57 -0500
Received: from kunet.com ([69.26.169.26]:27663 "EHLO kunet.com")
	by vger.kernel.org with ESMTP id S261648AbVBWWqZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 17:46:25 -0500
Message-ID: <007d01c519f9$7c9a5f50$7101a8c0@shrugy>
From: "Ammar T. Al-Sayegh" <ammar@kunet.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Cc: <linux-kernel@vger.kernel.org>
References: <009d01c519e8$166768b0$7101a8c0@shrugy> <1109192040.6290.108.camel@laptopd505.fenrus.org> <003001c519f1$031afc00$7101a8c0@shrugy> <1109196074.6290.116.camel@laptopd505.fenrus.org>
Subject: Re: kernel BUG at mm/rmap.c:483!
Date: Wed, 23 Feb 2005 17:46:11 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="Windows-1252";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message ----- 
From: "Arjan van de Ven" <arjan@infradead.org>
To: "Ammar T. Al-Sayegh" <ammar@kunet.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Wednesday, February 23, 2005 5:01 PM
Subject: Re: kernel BUG at mm/rmap.c:483!


> On Wed, 2005-02-23 at 16:45 -0500, Ammar T. Al-Sayegh wrote:
>> > On Wed, 2005-02-23 at 15:41 -0500, Ammar T. Al-Sayegh wrote:
>> >> Hi All,
>> >> 
>> >> I recently installed Fedora RC3 on a new server.
>> >> The kernel is 2.6.10-1.741_FC3smp. The server
>> >> crashes every few days. When I examine /var/log/messages,
>> >> I find the following line just before the crash:
>> >> 
>> >> Feb 22 23:50:35 hostname kernel: ------------[ cut here ]------------
>> >> Feb 22 23:50:35 hostname kernel: kernel BUG at mm/rmap.c:483!
>> >> 
>> >> No further debug lines are given to diagnose the
>> >> source of the 
>> > no oops at all?
>> 
>> No. Is there a way to enable the kernel to give more
>> diagnostic debug output next time this error happens?
> 
> not really; it was supposed to do that already
> 
>> i2c_dev                13249  0 
>> i2c_core               24513  1 i2c_dev
> 
> try for fun to not use i2c for a while
> 
>> microcode              11489  0 
> same for microcode... try removing that so that the microcode of your
> system doesn't get updated at boot

What do these two modules do in particular? and how can I disable
them so that they don't get reloaded during boot time? do I need
to disable both i2c_dev and i2c_core or just one of them?

Thanks.


-ammar
