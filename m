Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129933AbQLQAi7>; Sat, 16 Dec 2000 19:38:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130211AbQLQAiu>; Sat, 16 Dec 2000 19:38:50 -0500
Received: from blackdog.wirespeed.com ([208.170.106.25]:9229 "EHLO
	blackdog.wirespeed.com") by vger.kernel.org with ESMTP
	id <S129933AbQLQAih>; Sat, 16 Dec 2000 19:38:37 -0500
Message-ID: <3A3C0311.2060205@redhat.com>
Date: Sat, 16 Dec 2000 18:04:33 -0600
From: Joe deBlaquiere <jadb@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22 i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Samuelson <peter@cadcamlab.org>
CC: Werner Almesberger <Werner.Almesberger@epfl.ch>, ferret@phonewave.net,
        Alexander Viro <viro@math.psu.edu>, LA Walsh <law@sgi.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linus's include file strategy redux
In-Reply-To: <20001215152137.K599@almesberger.net> <Pine.LNX.3.96.1001215090857.16439A-100000@tarot.mentasm.org> <20001215184644.R573@almesberger.net> <3A3A7F25.2050203@redhat.com> <20001215222707.T573@almesberger.net> <3A3AA21F.4060100@redhat.com> <20001216165037.K3199@cadcamlab.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Last I recall you have to at least have newlib around to get through the 
build process of gcc. libgcc doesn't affect the kernel but you can't do 
'make install' without building it.

BTW : The Linux newlib stuff should go a long way toward solving some of 
these problems (at least for x86 these days... other arches sure to follow)

Peter Samuelson wrote:

> [Joe deBlaquiere]
> 
>> might be a good newbie filter... but actually the best thing about it
>> is that the compiler people of the work might make generating a
>> proper cross-toolchain less difficult by one or two magnitudes...
> 
> 
> *WHAT*?  How much less difficult could it possibly get?  This is the
> kernel, there is no cross-libc to worry about, so a cross-toolchain is
> already down to a pair of CMMIs[1].
> 
> I do agree that anyone who can't do *that* should probably be using a
> distro-packaged kernel....
> 
> Peter
> 
> [1] configure-make-make-install


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
