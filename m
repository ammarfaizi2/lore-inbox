Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287918AbSABTau>; Wed, 2 Jan 2002 14:30:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287913AbSABTak>; Wed, 2 Jan 2002 14:30:40 -0500
Received: from svr3.applink.net ([206.50.88.3]:11526 "EHLO svr3.applink.net")
	by vger.kernel.org with ESMTP id <S287918AbSABTaU>;
	Wed, 2 Jan 2002 14:30:20 -0500
Message-Id: <200201021930.g02JUCSr021556@svr3.applink.net>
Content-Type: text/plain; charset=US-ASCII
From: Timothy Covell <timothy.covell@ashavan.org>
Reply-To: timothy.covell@ashavan.org
To: adrian kok <adriankok2000@yahoo.com.hk>, linux-kernel@vger.kernel.org
Subject: Re: system.map
Date: Wed, 2 Jan 2002 13:26:29 -0600
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020102191157.49760.qmail@web21204.mail.yahoo.com>
In-Reply-To: <20020102191157.49760.qmail@web21204.mail.yahoo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 January 2002 13:11, adrian kok wrote:
> Hi all
>
> Why sometimes I don't need to copy the system.map to
> /boot when I update the kernel
> and the system also can boot?
>
> Is it correct?
>
> Thank you
>
>
System.map is not required for everyday use of the OS.
It contains symbols which are useful for debugging and
such.   In normal usage, you can ignore the warnings which
as spit out by "ps", and others (?).  

	Of course, you can copy over the new System.map
file to /boot,  but their is no (easy) way of having more than
one active version via "lilo" or "grub".   And that could be 
considered a deficiency of the Linux OS.


-- 
timothy.covell@ashavan.org.
