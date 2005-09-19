Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932318AbVISFoF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbVISFoF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 01:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932319AbVISFoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 01:44:05 -0400
Received: from rwcrmhc12.comcast.net ([204.127.198.43]:7555 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932318AbVISFoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 01:44:04 -0400
Message-ID: <432E5024.20709@namesys.com>
Date: Sun, 18 Sep 2005 22:44:04 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
CC: thenewme91@gmail.com, Christoph Hellwig <hch@infradead.org>,
       Denis Vlasenko <vda@ilport.com.ua>, chriswhite@gentoo.org,
       LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
References: <200509182004.j8IK4JNx012764@inti.inf.utfsm.cl>
In-Reply-To: <200509182004.j8IK4JNx012764@inti.inf.utfsm.cl>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:

>
>>>that and there's much more exciting filesystems like ocfs2 around that
>>>      
>>>
>
>  
>
>>This is exciting to... whom?
>>    
>>
>
>To Cristoph, obviously. You should thank him for doing the (hard, boring,
>thankless) work of reviewing code for free. Even if it isn't yours. As he
>is doing it as community service, I wouldn't dare blame him for picking
>whatever he likes most, for whatever reasons.
>  
>
Well maybe he should just go away then and save his and our time. 
Reiser4 works just fine without Christoph.  Users are happy with it. 
None of them have asked for his help.  I don't consider Christoph to be
qualified to work on our filesystem.  I would not hire him if he applied
--- he is not capable of innovative work.

Reiser4 is far from perfect, but it is ready for more users.

>
>>Is that Hans' fault, or the fault of your lot?  Why can't we all just get
>>along?
>>    
>>
>
>Hans is one person, and he has managed to alienate a most of the LKML
>bunch. Sure, there are very abrasive people here, but there are plenty that
>are extremely helpful to newbies that /really/ want to learn how to do
>things right.
>  
>
Yes, but the helpful ones have nothing to do with VFS.  Linux has lost
filesystem developers because of the VFS team, developers who I can tell
you were very very  gifted DARPA researchers who decided to work on BSD
because they had too much dignity to develop a filesystem for  Linux.  I
assure you that no one on the VFS team is as bright or capable as one of
the fellows I know of that they abused away.

>>If you don't have the time to review, then please hold off on replying
>>until you have a through review of at least part of the code.
>>    
>>
>
>Can't do. It is mostly an artistic sense of taste.
>  
>
Yes, which is why people who have not written a serious filesystem
should not instruct those who have written the measurably fastest one.

> Also, let's say that Reiser4 doesn't get into the kernel, as maybe XFS
>
>>or ext2 or ext3 had never gotten into the kernel.  How would their
>>development be now as opposed to how we see it, when they have gotten
>>into the kernel?  I don't see anything wrong with the idea of letting
>>what seems a mostly mature FS into the kernel; that is how most bugs
>>are found in the first place.  Of course, there is nothing wrong with
>>putting huge warnings on the FS; I'd recommend them, considering that
>>some people are having funky problems with the patch.
>>    
>>
>
>Just unloading some untested code on unsuspecting, innocent users is not
>very nice, is it?
>  
>
Christoph is not testing.  We have tested, our mailing list has tested.....

> There are lots of reports of ReiserFS 3
>
>filesystems completely destroyed by minor hardware flakiness. And that has
>/never/ been fixed, as the developers just went off to do the "next cool
>thing". That history weighs against ReiserFS, heavily.
>  
>
We are supposed to write a filesystem so that overheating CPUs do not
make it crash?

Prejudice is a very simple phenomenom.  When either ext3 or ReiserFS V3
crash it is almost always due to bad hardware.  Prejudice is the process
of remembering that one filesystem crashed due to bad hardware and not
remembering that the other one crashed.

It is remarkably simple how it works: people who use Reiser4 want it in,
people who use ext3 and don't want to have a choice of something else
don't want it in.  That was true of V3, and it is true of V4.  My point
of course is that those who have used V4 know more about it than those
who haven't......

I think Alan Cox is the only poster who has no intention of using
Reiser4 but said at one point that he thinks it should go in.

V3 is obsoleted by V4 in every way.  V3 is old code that should be
marked as deprecated as soon as V4 has passed mass testing.   V4 is far
superior in its coding style also.  Having V3 in and V4 out is at this
point just stupid. 

This whole thing reminds me of an IBMer who told me that he thought that
IBM lost to MS because they called OS/2 by a name other than DOS.  The
sad thing is he was probably right. 

V4, as it is today, is as much superior to V3 as OS/2 was to DOS.  Any
distro or user who would stay with V3 for new installs once we have
passed mass testing is nuts.  We need the mass testing.

Hans
