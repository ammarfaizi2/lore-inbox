Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264129AbTLXXMZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 18:12:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264134AbTLXXMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 18:12:24 -0500
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:10236 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S264129AbTLXXMR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 18:12:17 -0500
Message-ID: <3FEA1D50.5040203@rackable.com>
Date: Wed, 24 Dec 2003 15:12:16 -0800
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: Arjan van de Ven <arjanv@redhat.com>,
       Bruce Ferrell <bferrell@baywinds.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: is it possible to have a kernel module with a BSD license?!
References: <3FE9ADEE.1080103@baywinds.org> <1072282214.5267.0.camel@laptop.fenrus.com> <20031224221114.GB6438@matchmail.com>
In-Reply-To: <20031224221114.GB6438@matchmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Dec 2003 23:12:16.0600 (UTC) FILETIME=[5F559580:01C3CA73]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk wrote:
> On Wed, Dec 24, 2003 at 05:10:14PM +0100, Arjan van de Ven wrote:
> 
>>On Wed, 2003-12-24 at 16:17, Bruce Ferrell wrote:
>>
>>>from the project announcement on freshmeat:
>>>
>>>
>>>  Dazuko 2.0.0-pre5 (Default)
>>>  by John Ogness - Tuesday, November 11th 2003 06:56 PST
>>>
>>>About:
>>>This project provides a kernel module which provides 3rd-party 
>>>applications with an interface for file access control. It was 
>>>originally developed for on-access virus scanning. Other uses include a 
>>>file-access monitor/logger or external security implementations. It 
>>>operates by intercepting file-access calls and passing the file 
>>>information to a 3rd-party application. The 3rd-party application the
>>
>>I think you need to look further; the linux kernel portion sure is GPL
>>...
> 
> 
> Then the wrapper can be GPL then and the rest BSD?

   Exactly a module intended to run on both linux, and say freebsd would 
not be a derived work of linux.  (At least if I'm understanding Linus 
right.) The portion that interfaces with linux would obvious be a 
derived work.  It could be very easily (correctly imho)) argued that the 
module when compiled for linux would be bound by the gpl. In fact you'd 
be better off dual licensing the generic sections under both BSD, and 
GPL, while leaving linux wrapper gpl, and the *BSD wrapper BSD.

http://groups.google.com/groups?q=linus+derived+work&hl=en&lr=&ie=UTF-8&oe=UTF-8&selm=YPep.5Y5.21%40gated-at.bofh.it&rnum=1

PS- IANAL!
-- 
There is no such thing as obsolete hardware.
Merely hardware that other people don't want.
(The Second Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>

