Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129345AbQLLACv>; Mon, 11 Dec 2000 19:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129908AbQLLACl>; Mon, 11 Dec 2000 19:02:41 -0500
Received: from web216.mail.yahoo.com ([128.11.68.116]:15377 "HELO
	web216.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129314AbQLLAC0>; Mon, 11 Dec 2000 19:02:26 -0500
Message-ID: <20001211233159.12922.qmail@web216.mail.yahoo.com>
Date: Mon, 11 Dec 2000 15:31:59 -0800 (PST)
From: Jean Fekry Rizk <jeanfekry@yahoo.com>
Subject: Re: Linking with kernel code (Makefile)
To: David Feuer <David_Feuer@brown.edu>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your advice,

I already know one way to accomodate shared memory between a user process
and the kernel.
This is done by making a character device which allocates memory in the
kernel, then from the user appl, using the mmap function of the driver.

I was only wondering why I could not link my code with the kernel, though
they are compiled together, this means I should be able to use any
function in the kernel files as long as I succeed to define it right

So in my question X would be any application, Y would be linking my code
with the kernel and Z would be to get more control over structures

--- David Feuer <David_Feuer@brown.edu> wrote:
> At 03:12 PM 12/10/2000 -0800, you wrote:
> >Hi Kernel World,
> >I'm new to linux-kernel developement, so I would appreciate any help.
> >
> >What I want to do:
> >     create a shared memory segment between user space and kernel space
> 
> Generally, you can get the most useful help from linux-kernel if as well
> as 
> saying what you do you also say _why_.  So if you say you are developing
> an 
> application to do X, and you want to interact with the kernel in a
> certain 
> way Y because Z, then if Y is the correct way to accomplish X, people
> will 
> tell you how.  If, however, there is a better way, they will tell you
> this 
> instead.  Sorry, I don't know anything about the particular question you
> 
> posted, but if you want my own uneducated guess, I will guess that it's
> not 
> possible.
> 
> --
> This message has been brought to you by the letter alpha and the number
> pi.
> Open Source: Think locally; act globally.
> David Feuer
> David_Feuer@brown.edu
> 


__________________________________________________
Do You Yahoo!?
Yahoo! Shopping - Thousands of Stores. Millions of Products.
http://shopping.yahoo.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
