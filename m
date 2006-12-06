Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760650AbWLFOYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760650AbWLFOYq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 09:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760649AbWLFOYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 09:24:46 -0500
Received: from belize.chezphil.org ([80.68.91.122]:3593 "EHLO
	belize.chezphil.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760650AbWLFOYo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 09:24:44 -0500
To: "Frederik Deweerdt" <deweerdt@free.fr>
Cc: <linux-kernel@vger.kernel.org>
Date: Wed, 06 Dec 2006 14:24:42 +0000
Subject: Re: Subtleties of __attribute__((packed))
Message-ID: <1165415082132@dmwebmail.belize.chezphil.org>
In-Reply-To: <20061206140138.GA16350@slug>
References: <20061206140138.GA16350@slug>
X-Mailer: Decimail Webmail 3alpha14
MIME-Version: 1.0
Content-Type: text/plain; format="flowed"
From: "Phil Endecott" <phil_arcwk_endecott@chezphil.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frederik Deweerdt wrote:
> On Wed, Dec 06, 2006 at 01:20:41PM +0000, Phil Endecott wrote:
>> I used to think that this:
>> 
>> struct foo {
>>   int a  __attribute__((packed));
>>   char b __attribute__((packed));
>>   ... more fields, all packed ...
>> };
>> 
>> was exactly the same as this:
>> 
>> struct foo {
>>   int a;
>>   char b;
>>   ... more fields ...
>> } __attribute__((packed));
>> 
>> but it is not, in a subtle way.
>> 
> This is likely a gcc bug isn't it? The gcc info page states:
>   Specifying this attribute for `struct' and `union' types is
>   equivalent to specifying the `packed' attribute on each of the
>   structure or union members.

A gcc *documentation* bug?

I asked on the gcc list about this before posting here, and although 
replies are still coming in the first opinion was "it's doing exactly 
what you asked it to do".

Phil.




