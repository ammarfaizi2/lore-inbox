Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129823AbQLOXcr>; Fri, 15 Dec 2000 18:32:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129896AbQLOXch>; Fri, 15 Dec 2000 18:32:37 -0500
Received: from blackdog.wirespeed.com ([208.170.106.25]:13319 "EHLO
	blackdog.wirespeed.com") by vger.kernel.org with ESMTP
	id <S129823AbQLOXc0>; Fri, 15 Dec 2000 18:32:26 -0500
Message-ID: <3A3AA21F.4060100@redhat.com>
Date: Fri, 15 Dec 2000 16:58:39 -0600
From: Joe deBlaquiere <jadb@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22 i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To: Werner Almesberger <Werner.Almesberger@epfl.ch>
CC: ferret@phonewave.net, Alexander Viro <viro@math.psu.edu>,
        LA Walsh <law@sgi.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linus's include file strategy redux
In-Reply-To: <20001215152137.K599@almesberger.net> <Pine.LNX.3.96.1001215090857.16439A-100000@tarot.mentasm.org> <20001215184644.R573@almesberger.net> <3A3A7F25.2050203@redhat.com> <20001215222707.T573@almesberger.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Werner Almesberger wrote:

> Joe deBlaquiere wrote:
> 
>> My solution to this has always been to make a cross compiler environment 
> 
> 
> ;-))) I think lots of people would really enjoy to have "build a
> cross-gcc" added to the prerequisites for installing some driver
> module ;-)
> 
> I know, it's not *that* bad. But it still adds quite a few possible
> points of failure. Also, it adds a fair amount of overhead to any
> directory name change or creation of a new kernel tree.
> 

might be a good newbie filter... but actually the best thing about it is 
that the compiler people of the work might make generating a proper 
cross-toolchain less difficult by one or two magnitudes...

> 
>> The other advantage to this is that I can switch my host environment 
>> (within reason - compatible host glibcs, ok) and not have to change the 
>> target compiler.
> 
> 
> Hmm, I don't quite understand what you mean here.
> 

This way I can upgrade my host system from RH6.2 to RH7 and not worry 
about compiler differences affecting my kernel builds for the various 
projects I'm working on... including systems based on 2.0, 2.2 and 2.4...

If anybody thinks gcc-2.96 messes up a 2.4 kernel, you should see what 
happens when you compile 2.0.33 ;o).

> - Werner


-- 
Joe deBlaquiere
Red Hat, Inc.
307 Wynn Drive
Huntsville AL, 35805
voice : (256)-704-9200
fax   : (256)-837-3839

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
