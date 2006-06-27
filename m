Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932387AbWF0QBf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbWF0QBf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 12:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932485AbWF0QBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 12:01:35 -0400
Received: from wx-out-0102.google.com ([66.249.82.202]:51726 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932387AbWF0QBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 12:01:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Bi5bmhwcVPkyY7X55jR38Dv7eXH1N4aG5In+HDHZLi0r6u+vpxdqW+JrhKNMjgyS31TLUlzLf4PXNZAlKqK7ailPC6yU1qmODpK1jOqbgn79G3RsPHz/HWWXFFS56uhq6fP+2yHpFg9MMobwLM40qC3MgjDsLjcHgV7di8UBiUc=
Message-ID: <3aa654a40606270901k4af63de8oe9aa7dde2a2d6a22@mail.gmail.com>
Date: Tue, 27 Jun 2006 09:01:33 -0700
From: "Avuton Olrich" <avuton@gmail.com>
To: "Andreas Mohr" <andi@rhlx01.fht-esslingen.de>
Subject: Re: [Suspend2-devel] Re: Suspend2 - Request for review & inclusion in -mm
Cc: "Brad Campbell" <brad@wasp.net.au>, "Pavel Machek" <pavel@ucw.cz>,
       "Nigel Cunningham" <ncunningham@linuxmail.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       suspend2-devel@lists.suspend2.net
In-Reply-To: <20060627154130.GA31351@rhlx01.fht-esslingen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200606270147.16501.ncunningham@linuxmail.org>
	 <20060627133321.GB3019@elf.ucw.cz> <44A14D3D.8060003@wasp.net.au>
	 <20060627154130.GA31351@rhlx01.fht-esslingen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/06, Andreas Mohr <andi@rhlx01.fht-esslingen.de> wrote:
> Hi,
>
> On Tue, Jun 27, 2006 at 07:22:37PM +0400, Brad Campbell wrote:
> > Pavel Machek wrote:
> > >>Some of the advantages of suspend2 over swsusp and uswsusp are:
> > >>
> > >>- Speed (Asynchronous I/O and readahead for synchronous I/O)
> > >
> > >uswsusp should be able to match suspend2's speed. It can do async I/O,
> > >etc...
> >
> > ARGH!
> >
> > And the next version of windows will have all the wonderful features that
> > MacOSX has now so best not upgrade to Mac as you can just wait for the
> > next version of windows.
> >
> > suspend2 has it *now*. It works, it's stable.

I'm not sure it's a reason for it to go in, but the truth is suspend2
does work in more cases, ime. uswsusp is alpha(?) swsusp doesn't work
(for me in most cases), suspend-to-ram doesn't work (probably even
less cases than swsusp), suspend2 works. It's working status for more
of the userbase should (hopefully) be a concideration.
-- 
avuton
--
 Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
