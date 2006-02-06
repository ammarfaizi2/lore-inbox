Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932218AbWBFQxV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbWBFQxV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 11:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbWBFQxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 11:53:20 -0500
Received: from [202.131.75.34] ([202.131.75.34]:19415 "EHLO
	mail.shaolinmicro.com") by vger.kernel.org with ESMTP
	id S932218AbWBFQxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 11:53:20 -0500
Message-ID: <43E77EEA.7040908@shaolinmicro.com>
Date: Tue, 07 Feb 2006 00:52:58 +0800
From: David Chow <davidchow@shaolinmicro.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jes Sorensen <jes@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux drivers management
References: <43E71AD7.5070600@shaolinmicro.com> <yq0d5i0ol4i.fsf@jaguar.mkp.net>
In-Reply-To: <yq0d5i0ol4i.fsf@jaguar.mkp.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>David> separate Linux drivers and the the main kernel, and manage
>David> drivers using a package management system that only manages
>David> kernel drivers and modules? If this can be done, the kernel
>David> maintenance can be simple, and will end-up with a more stable
>David> (less frequent changed) kernel API for drivers, also make every
>David> developers of drivers happy.
>
>David> Would like to see that happens .
>
>Simple answer: no
>
>Maybe someone is working on it, but it's highly unlikely to be
>anything but a waste of that person's time.
>
>This is a classic question, by seperating out the drivers you make it
>so much harder for all developers to propagate changes into all pieces
>of the tree.
I write drivers, never need to change kernel if the kernel API is mature 
enough to provide the need of a module developer needs. There is no 
reason to make changes to the kernel source, only needed because the 
original kernel code is crap or the API designed without proper 
software/system architectural design work effort. Each Linux kernel 
version go through a lengthy beta release cycle (e.g. 2.3, 2.5, 2.7), 
this shouldn't happen and idea collection should be enough through this 
large Linux community.

If our time is to focus on kernel's kernel, writing good documentation 
about a stable kernel API, it will benefit many developers to write 
drivers to Linux . It is too difficult to learn, this is a main reason 
why Linux is lack of support from manufacturer drivers, not because they 
don't like Linux and no market, it is because this has created high 
entry barrier for them.

I've been working on Linux modules for many years, training my 
engineers, talking to developers, hw manufacturers .. believe it or not, 
this is the main reason. They all ask for a DDK for Linux that can make 
drivers easily for their product.

I think I am in a different position like you guys, I've been work with 
Linux from programmer level to Linux promotion . My goal is not just 
focus on Linux technical or programming, I would like to promote this 
operating system to not just for programmers, but also non-technical 
end-users . Writing C code to me is just bits of task of some process.  
You are too much focus on programming without considering the market 
situation.

There is no right or wrong for this question, but my original question 
is to listen thoughts and to hear the goal of people in the list. And of 
course, I would really like to see you people look into the way to 
facilitate more people gets a path with ease to Linux drivers 
development. User driver installation without the need to know about 
kernel sources, gcc, make etc....  "Because I am a dummy, I want to 
plug-in my device, put in the driver disc and hope it works!"

regards,
David Chow
