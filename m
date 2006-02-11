Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932344AbWBKSra@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbWBKSra (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 13:47:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932351AbWBKSr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 13:47:29 -0500
Received: from xproxy.gmail.com ([66.249.82.201]:54077 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932344AbWBKSr3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 13:47:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:reply-to:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id:from;
        b=dZpkxZTYHnkRsR4HE4O71Rh2Jm4Wp62P/oukyOZSsfHkAJajDboAJtYmRAGOC4pDi9zmFcEr1YHKewClVJY2P2jpA+H6BmUVNrLTNvSxZ+Cd/azhQwnBbGxnd/KelOw12W+T38eiaAWXgbDIAHT5/elFozlGlSkYMUfyiJjn83Q=
Reply-To: ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com
To: David Chow <davidchow@shaolinmicro.com>
Subject: Re: Linux drivers management
Date: Sat, 11 Feb 2006 13:47:16 -0500
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org
References: <20060207044204.8908.qmail@science.horizon.com> <m1zml3rvkg.fsf@ebiederm.dsl.xmission.com> <43E8F8EB.8010800@shaolinmicro.com>
In-Reply-To: <43E8F8EB.8010800@shaolinmicro.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602111347.17127.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
From: Andrew James Wade <andrew.j.wade@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 February 2006 14:45, David Chow wrote:

Speaking as a Linux enthusiast:

> Technical End-Users:
> - Want to compile the drivers from source
     I want to be able to compile drivers from source. I'm not particularly
interested in actually doing so as I'm not mucking around with driver
source. I happen to be compiling drivers because I am interested in
mucking around with Linux kernel source, and the drivers are in-tree. But
if the fancy takes me to play around with driver source, I want to be able
to do so. Or perhaps I want to try out a kernel in which a driver API is
being developed, in which case I need to compile drivers as source, and
having them in-tree is convenient. 

> - Enjoy building their own kernel, apply patches (patch and make, it 
> works! thats cool....)
     I enjoy building my own kernel. Applying patches, not so much. I found
applying patches to get the latest -mm drudge work and I'm never able to
remember whether 2.6.16-rc2-mm1.bz2 applies to 2.6.16-rc2 or 2.6.16.
Fortunately I found a little utility called ketchup that handles the
details for me.

> - I don't mind to search for drivers and do it myself, because it was 
> fun to make something work with my effort :) .
     And here you go off the mark. It might be fun making that device work,
but if I'm working away at a different puzzle it'll probably be just an
annoyance. When it comes to parts of a system I'm not interested in at
the moment, I want them to "just work".

> - I don't mind to upgrade my OS because of a missing driver or needed 
> for new fucntionality. Even my application breaks, down time is not 
> important to my system because it s a sytsem for fun.
     Some down time is ok for me: I don't need 100% up-time on my system.
I can accept that the cost of running a beta system (-mm kernels) is that
it occasionally crashes, and the filesystems occasionally eat data (it's
happened to me once), but it's still a nuisance. People like me are
volunteers, if it become too inconvenient we'll simply stop volunteering.
     The barrier to entry for people like us also needs to be low. And here
the situation for the kernel is fairly good (due to the stable userspace
API). When switching to a development kernel the only other thing I
had to change was lilo; everything else just worked. 

     If the Linux development community is to benefit from volunteer
testers, hardware has to work not just for the stable kernels, but also
development kernels.

     As an aside, there is another good reason to update drivers not just
for stable driver APIs, but also APIs under development: quite apart
from testing, implementing APIs is a good way to find problems in the
design of the API. Notice the reluctance of the kernel maintainers to
merge any API that is not both implemented and used.

Andrew Wade
