Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932365AbWDKImG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbWDKImG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 04:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932358AbWDKImG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 04:42:06 -0400
Received: from wproxy.gmail.com ([64.233.184.230]:43389 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932364AbWDKImF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 04:42:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WCWymWjI4NPOUK2w9TH6C790TDAcmIlokFNKYOJRmT3R53XkF+iZ9QTXRV1dyGkw1emdBsbDcg1JiHP/p/FKoICqcBGplSLH7hcOvhjuV+aWnuj133H0tBpaoBHKTWHnWDF8Twj9G3tjEnT1TaNOyD9B/LyNMcBkZO5hX/r+qMU=
Message-ID: <9a8748490604110142j30b5986et4c02f06dd3754ca4@mail.gmail.com>
Date: Tue, 11 Apr 2006 10:42:04 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Ramakanth Gunuganti" <rgunugan@yahoo.com>
Subject: Re: GPL issues
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060411063127.97362.qmail@web54314.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060411063127.97362.qmail@web54314.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/06, Ramakanth Gunuganti <rgunugan@yahoo.com> wrote:
> I am trying to understand the GPL boundaries for
> Linux, any clarification provided on the following
> issues below would be great:
>
> As part of a project, I would like to extend the Linux
> kernel to support some additional features needed for
> the project, the changes will include:
>   o  Modification to Linux kernel.
>   o  Adding new kernel modules.
>   o  New system calls/IOCTLs to use the kernel
> modifications/LKMs.
>
> All kernel changes including LKMs will be released
> under GPL.
>
> Questions:
>

Note: The answers to the questions below are based on my own personal
understanding of the GPL and the policies of the Linux kernel.
Also contacting a lawyer would probably not be a bad idea.


> (Any reference to GPL license while answering these
> questions would be great)
>
> 1. If an application is built on top of this modified
> kernel, should the application be released under GPL?

No. Applications that merely use the services the kernel provides need
not be GPL.


> Do system calls provide a bounday for GPL? How does
> this work with LKMs, all the code for LKMs will be
> released but would a userspace application using the
> LKMs choose not to use GPL?
>
Again, a userspace application that merely use kernel services need not be GPL.


> 2. If the application has to be packaged with the
> Linux kernel, example: tarball that includes kernel +
> application, can this application be released without
> GPL. (The changes to Linux kernel are already released
> under GPL).
>
If the application is to be included in the mainline kernel tarball
and distributed from kernel.org, then I would say it would need to be
GPL.
If it's a tarball you provide with a modified kernel with all kernel
modifications released under GPL, then a userspace application bundled
in the tarball would not nessesarily need to be GPL.


> 3. How does this work if this application + kernel has
> to run on a proprietary system on a seperate interface
> card? Can I assume that once there is a clear hardware
> boundary rest of the software for the system does not
> have to be released under GPL? The software for the
> interface card will be built and distributed
> seperately from the rest of the software.
>
> 4. Can the GPL code and non-GPL code exist under the
> same source tree?
>
Not in the mainline kernel.


> 5. In case of litigation, will there be pressure to
> open up other parts of the software (non-GPL) running
> on the same system but on other hardware components
> interacting with this new package on a different
> interface card?
>
No idea.

> Anyone trying to build a new application to work on
> Linux must have these issues clarified, if you can
> share your experiences that would be great too.
>
> Thanks,
> Ram
>


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
