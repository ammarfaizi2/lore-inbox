Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266590AbUGUW5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266590AbUGUW5z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 18:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266635AbUGUW5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 18:57:54 -0400
Received: from web50902.mail.yahoo.com ([206.190.38.122]:18279 "HELO
	web50902.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266590AbUGUW5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 18:57:52 -0400
Message-ID: <20040721225752.90581.qmail@web50902.mail.yahoo.com>
Date: Wed, 21 Jul 2004 15:57:52 -0700 (PDT)
From: sankarshana rao <san_wipro@yahoo.com>
Subject: Re: Inode question
To: root@chaos.analogic.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.53.0407211708040.18371@chaos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guys,
Thx for the inputs...I got it with path_lookup....

Can I pass the inode pointer back to the user space???
I have a scenario in which I have to create multiple
folders on the harddisk. The number of folders can be
in hundreds. Instead of parsing the path name
everytime I need to create a folder (that's what
sys_mkdir does??? ), I was thinking if I have the
inode* of the parent folder, I can avoid this parsing
and directly create a subfolder under the parent
folder...

Pls advice if this approach makes sense or not and if
it is doable or not??

any input in this regard will be very helpful..


--- "Richard B. Johnson" <root@chaos.analogic.com>
wrote:
> On Wed, 21 Jul 2004, sankarshana rao wrote:
> 
> > Thx for the reply...
> > When I try to call lookup() from my kernel module,
> it
> > gives undefined symbol error during INSMOD..
> > any clues???
> >
> 
> It's probably not an exported symbol.
> 
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.4.26 on an i686 machine
> (5570.56 BogoMips).
>             Note 96.31% of all statistics are
> fiction.
> 
> 
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
