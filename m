Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262587AbUKXKOr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262587AbUKXKOr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 05:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262592AbUKXKOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 05:14:46 -0500
Received: from hermine.aitel.hist.no ([158.38.50.15]:22030 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S262587AbUKXKOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 05:14:05 -0500
Message-ID: <41A46085.5050602@hist.no>
Date: Wed, 24 Nov 2004 11:20:53 +0100
From: Helge Hafting <helge.hafting@hist.no>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tomas Carnecky <tom@dbservice.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel thoughts of a Linux user
References: <200411181859.27722.gjwucherpfennig@gmx.net> <419CFF73.3010407@dbservice.com> <41A19E44.9080005@hist.no> <41A1CAD4.20101@dbservice.com>
In-Reply-To: <41A1CAD4.20101@dbservice.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Carnecky wrote:

> Helge Hafting wrote:
>
>>> Is it possible to have two or more 'workstations' on one computer?
>>
>>
>> Yes - thats what the "ruby" kernel patch is all about.  I have a 
>> computer
>> with two "workstations" at home.  Compared to two computers, it
>> saves space, power, parts,  and above all - administrative work.  
>> Only one
>> machine to upgrade, secure, configure.
>>
>
> Thanks, that's what I've been looking for...
>
> From the documentation:
> The main problem up to this date (November 2004) is that linux kernel 
> has only one behaviour regarding multiple keyboards : any key pressed 
> catched on any keyboard is redirected to the one and only active 
> Virtual Terminal (VT).
>
> Will this be changed/improved when the console code is moved into 
> userspace, like some have proposed?

I don't know about any userspace console, but the ruby patch lets
you have several independent active VTs at the same time.  So
the above mentioned problem is solved - they keyboards does
not interfere with each other.

Helge Hafting
