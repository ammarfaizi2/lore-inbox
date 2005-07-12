Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261414AbVGLN2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261414AbVGLN2E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 09:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbVGLN2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 09:28:04 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16809 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261414AbVGLN2C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 09:28:02 -0400
Message-ID: <42D3C51D.3020703@redhat.com>
Date: Tue, 12 Jul 2005 09:26:53 -0400
From: Peter Staubach <staubach@redhat.com>
User-Agent: Mozilla Thunderbird  (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
CC: Marc Aurele La France <tsi@ualberta.ca>, linux-kernel@vger.kernel.org
Subject: Re: Kernel header policy
References: <200507120206.j6C26kGY017571@laptop11.inf.utfsm.cl>
In-Reply-To: <200507120206.j6C26kGY017571@laptop11.inf.utfsm.cl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:

>>I am contacting you to express my concern over a growing trend in kernel
>>development.  I am specifically referring to changes being made to kernel
>>headers that break compatibility at the userland level, where __KERNEL__
>>isn't #define'd.
>>    
>>
>
>The policy with respect to kernel headers is /very/ simple:
>
>  T H E Y   A R E   N E V E R   U S E D   F R O M   U S E R L A N D.
>
>This general policy makes all your points (trivially) moot.
>

I must admit a little confusion here.  Clearly, kernel header files are
used at the user level.  The kernel and user level applications must share
definitions for a great many things.

Perhaps more precisely, the rule is that kernel header files should not be
#include'd directly from user level applications, but may be #include'd
indirectly through other header files as appropriate?

    Thanx...

       ps
