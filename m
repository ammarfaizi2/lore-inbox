Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932446AbWGHEdN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446AbWGHEdN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 00:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932509AbWGHEdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 00:33:13 -0400
Received: from wx-out-0102.google.com ([66.249.82.193]:48203 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932446AbWGHEdM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 00:33:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UIQ133otOtgIwfxzxKYtW/3msv/xdW8nTaFka59S12P50tGE8yVISsdpLzdSJZTNzFsOvFi+vQDYGOhco6BhbZLjJZq+17tK2MWnKcJUzvA3d4zSNzyl+RkDh8h8BuPTZGMxbQvP6ngGQGcsdJXsIahI4pznlNAAGYujfq6+8TU=
Message-ID: <3aa654a40607072133i55ffe0d1ke9f0905c6599864c@mail.gmail.com>
Date: Fri, 7 Jul 2006 21:33:11 -0700
From: "Avuton Olrich" <avuton@gmail.com>
To: "Pavel Machek" <pavel@ucw.cz>
Subject: Re: uswsusp history lesson [was Re: [Suspend2-devel] Re: swsusp / suspend2 reliability]
Cc: "Nigel Cunningham" <ncunningham@linuxmail.org>,
       suspend2-devel@lists.suspend2.net,
       "Olivier Galibert" <galibert@pobox.com>, grundig <grundig@teleline.es>,
       jan@rychter.com, linux-kernel@vger.kernel.org
In-Reply-To: <20060708002826.GD1700@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060627133321.GB3019@elf.ucw.cz>
	 <20060707215656.GA30353@dspnet.fr.eu.org>
	 <20060707232523.GC1746@elf.ucw.cz>
	 <200607080933.12372.ncunningham@linuxmail.org>
	 <20060708002826.GD1700@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/06, Pavel Machek <pavel@ucw.cz> wrote:
> Now... switching to uswsusp kernel parts will make it slightly harder
> to install in the short term (messing with initrd). OTOH there's at
> least _chance_ to get to the point where suspend "just works" in
> Linux, in the long term...

Long term being the key words. When will uswsusp be concidered 'rock
solid'? 2008+? Suspend2 is rock solid _today_. Imagine a world where
Linux drivers were as reliable as swsusp (granted I tried to get
uswsusp working and I gave up before messing with the initrd stuff).
I'm not even talking about all the extra features of Suspend2.

Maybe it's worth thinking about at least helping it get into -mm
before complaining about lack of testing Suspend2 has had. Sounds like
people are willing to do the work it would take to get it in, it
appears there is no vehicle at this point.
-- 
avuton
--
 Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
