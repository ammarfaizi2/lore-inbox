Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261603AbUK1XiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbUK1XiN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 18:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbUK1XiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 18:38:13 -0500
Received: from web51902.mail.yahoo.com ([206.190.39.45]:63418 "HELO
	web51902.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261603AbUK1Xhv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 18:37:51 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=01Xxv8RnVdWhZK90Po9j1/P9GkaC3q/t9QqAXhvxY7xcb6rWOuHlCjfVZ5WOdksR/LZYubzVwx9GBknNLHtOxeOENe7xPh44H/xnW/Qsh6fhssEoPZ28qG6UWR4ExyTZl2UzNWwBwYGqaLAF4VP3dTkY5BrAiZEpXVLwXtRNwYg=  ;
Message-ID: <20041128233747.53950.qmail@web51902.mail.yahoo.com>
Date: Sun, 28 Nov 2004 15:37:47 -0800 (PST)
From: A M <alim1993@yahoo.com>
Subject: Re: Accessing a process structure in the processes link list
To: Doug McNaught <doug@mcnaught.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <874qj9lg7t.fsf@asmodeus.mcnaught.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How would you know the offset (location of index 0 if
it was an array or the head of link list) of that
variable in memory, in this case it is the process
table named task of type a pointer to task_struct? 

Any recommendation for references will be appreciated.


Thanks, 

Ali 

--- Doug McNaught <doug@mcnaught.org> wrote:

> A M <alim1993@yahoo.com> writes:
> 
> > Would it be possible for a program running as root
> > that wasn't compiled with the kernel to access a
> > process structure in the processes link list? 
> 
> Yes, but see below.
> 
> > I've read an article about hiding processes and
> the
> > article made sound so easy to access the link list
> and
> > hide a process, how easy is it?
> 
> You need read access to /dev/kmem and a fairly
> intimate knowledge of
> the kernel data structures in question.
>  
> > Is it possible to a process to access its own
> entry in
> > the processes link list?
> 
> Not without read access to the kmem device...
> 
> -Doug
> 



		
__________________________________ 
Do you Yahoo!? 
The all-new My Yahoo! - Get yours free! 
http://my.yahoo.com 
 

