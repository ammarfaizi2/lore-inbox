Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312488AbSDCXlu>; Wed, 3 Apr 2002 18:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312491AbSDCXlk>; Wed, 3 Apr 2002 18:41:40 -0500
Received: from tomts11.bellnexxia.net ([209.226.175.55]:64724 "EHLO
	tomts11-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S312488AbSDCXld>; Wed, 3 Apr 2002 18:41:33 -0500
Date: Wed, 3 Apr 2002 18:41:32 -0500 (EST)
From: Craig <penguin@wombat.ca>
X-X-Sender: carsnau@wombat
To: Andi Kleen <ak@suse.de>
cc: linux-kernel@vger.kernel.org, <marcelo@conectiva.com.br>
Subject: Re: [PATCH] 2.4: BOOTPC /proc info.
In-Reply-To: <p73vgb8s6e1.fsf@oldwotan.suse.de>
Message-ID: <Pine.LNX.4.42.0204031837450.711-100000@wombat>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 Apr 2002, Andi Kleen wrote:

> Craig <penguin@wombat.ca> writes:
>
> > Marcelo,
> >   This patch is against 2.4.19-pre5, please apply.
>
> This is unbelievable ugly. Can't you just save the packet as a binary
> buffer, output it as binary in /proc and parse and format it in user space ?
>

Sure, we *could* have done that.  We chose not to because some of the user space
programs were having problems during bootup times.  Instead, we did it in the
kernel for our specific application as that was the better place where we had
more control (for *our* application).

> Better would be to not use bootpc at all in kernel, but run it in initrd
> (that is the long term plan anyways, removing dhcp/bootp completely
> and only supporting them from initrd)
>

Yes, Alan mentions the same thing.
We didn't realize that was the long term plan.  Is that documented anywhere, or
was it discussed on this list eons ago and 'decided'? ;)

--
Craig.
+------------------------------------------------------+
http://www.wombat.ca               Why? Why not.
http://www.washington.edu/pine/    Pine @ the U of Wash.
+-------------=*sent via Pine4.42*=--------------------+



