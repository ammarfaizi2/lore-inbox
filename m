Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261735AbVDWTOc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbVDWTOc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 15:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261731AbVDWTOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 15:14:30 -0400
Received: from simmts8.bellnexxia.net ([206.47.199.166]:18827 "EHLO
	simmts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261720AbVDWTOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 15:14:19 -0400
Message-ID: <1242.10.10.10.24.1114280097.squirrel@linux1>
In-Reply-To: <20050423190257.GA4194@cip.informatik.uni-erlangen.de>
References: <200504210422.j3L4Mo8L021495@hera.kernel.org>
    <42674724.90005@ppp0.net> <20050422002922.GB6829@kroah.com>
    <426A4669.7080500@ppp0.net>
    <1114266083.3419.40.camel@localhost.localdomain>
    <426A5BFC.1020507@ppp0.net>
    <1114266907.3419.43.camel@localhost.localdomain>
    <Pine.LNX.4.58.0504231010580.2344@ppc970.osdl.org>
    <2646.10.10.10.24.1114278656.squirrel@linux1>
    <20050423190257.GA4194@cip.informatik.uni-erlangen.de>
Date: Sat, 23 Apr 2005 14:14:57 -0400 (EDT)
Subject: Re: Git-commits mailing list feed.
From: "Sean" <seanlkml@sympatico.ca>
To: "Thomas Glanzmann" <sithglan@stud.uni-erlangen.de>
Cc: "Linus Torvalds" <torvalds@osdl.org>,
       "David Woodhouse" <dwmw2@infradead.org>,
       "Jan Dittmer" <jdittmer@ppp0.net>, "Greg KH" <greg@kroah.com>,
       "Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Git Mailing List" <git@vger.kernel.org>
User-Agent: SquirrelMail/1.4.4-2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, April 23, 2005 3:02 pm, Thomas Glanzmann said:
> Hello,
>
>> Why not leave tags open to being signed or unsigned?
>
> I think that this is the idea anyway.
>
>> For presentation in the log or whatever, the script can look inside the
>> clear text message, grab the SHA1 and display it in the header area;
>> even
>> though it's not really in the header, always just in the clear text
>> area.
>
> Having the SHA1 signature twice in would be confusing and error-prone
> when checking is done automated.
>
> So establishing the infrastructure is a good thing. To use it for every
> commit is another issue.


There's no need to have the SHA1 object reference twice.  It will only be 
in the clear text, nowhere else.  Of course scripts that display the log,
could show the object reference in the header area for aesthetics. 
Another nice thing is that this works no matter cleartext signing methods
emerge in the future.

Sean



