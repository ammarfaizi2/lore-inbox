Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262402AbSI2GI5>; Sun, 29 Sep 2002 02:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262403AbSI2GI4>; Sun, 29 Sep 2002 02:08:56 -0400
Received: from mailhost2-bcvloh.bcvloh.ameritech.net ([66.73.20.44]:21935 "EHLO
	mailhost.bcv2.ameritech.net") by vger.kernel.org with ESMTP
	id <S262402AbSI2GIz> convert rfc822-to-8bit; Sun, 29 Sep 2002 02:08:55 -0400
Content-Type: text/plain; charset=US-ASCII
From: james <jdickens@ameritech.net>
To: Linus Torvalds <torvalds@transmeta.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: v2.6 vs v3.0
Date: Sun, 29 Sep 2002 01:14:15 -0500
User-Agent: KMail/1.4.3
Cc: Jeff Garzik <jgarzik@pobox.com>, Larry Kessler <kessler@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       "Andrew V. Savochkin" <saw@saw.sw.com.sg>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Richard J Moore <richardj_moore@uk.ibm.com>
References: <Pine.LNX.4.44.0209281826050.2198-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0209281826050.2198-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209290114.15994.jdickens@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 28 September 2002 08:31 pm, Linus Torvalds wrote:
> On Sat, 28 Sep 2002, Ingo Molnar wrote:
> > i consider the VM and IO improvements one of the most important things
> > that happened in the past 5 years - and it's definitely something that
> > users will notice. Finally we have a top-notch VM and IO subsystem (in
> > addition to the already world-class networking subsystem) giving
> > significant improvements both on the desktop and the server - the jump
> > from 2.4 to 2.5 is much larger than from eg. 2.0 to 2.4.
>
> Hey, _if_ people actually are universally happy with the VM in the current
> 2.5.x tree, I'll happily call the dang thing 5.0 or whatever (just
> kidding, but yeah, that would be a good enough reason to bump the major
> number).
>
> However, I'll believe that when I see it. Usually people don't complain
> during a development kernel, because they think they shouldn't, and then
> when it becomes stable (ie when the version number changes) they are
> surprised that the behabviour didn't magically improve, and _then_ we get
> tons of complaints about how bad the VM is under their load.
>
> Am I hapyy with current 2.5.x?  Sure. Are others? Apparently. But does
> that mean that we have a top-notch VM and we should bump the major number?
> I wish.
>
> The block IO cleanups are important, and that was the major thing _I_
> personally wanted from the 2.5.x tree when it was opened. I agree with you
> there. But I don't think they are major-number-material.
>
> Anyway, people who are having VM trouble with the current 2.5.x series,
> please _complain_, and tell what your workload is. Don't sit silent and
> make us think we're good to go.. And if Ingo is right, I'll do the 3.0.x
> thing.
>
How many people are sitting on the sidelines waiting for guarantee that ide is 
not going to blow up on our filesystems and take our data with it. Guarantee 
that ide is working and not dangerous to our data, then I bet a lot more 
people will come back and bang on 2.5. 

I know this whole ide mess have taken me away from the devolemental series. 
And I bet a lot of others. 

My vote for reason to advance to v3.0 would be more based on our filesystems 
surport. .i.e. XFS and the latest Reiserfs and redoing our middle layer, 
.i.e. treating a cdrw as another drive instead of an ide-scsi device and 
ridding us of  /dev/[hs][dg][a=z] and replacing it with a lot saner 
replacement (I know this talked about it, don't know if it has been or will 
be implemented.)   Along with the changes others have mentioned, but I really 
can't judge those because I have not used 2.5 lately for reasons stated 
above. 

Sincerly 
 
James




> 		Linus
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

