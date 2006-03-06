Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752442AbWCFV5P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752442AbWCFV5P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 16:57:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752441AbWCFV5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 16:57:15 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:30223 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752445AbWCFV5L convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 16:57:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FH6D31KhESvlQdX6ZpnKHpAW8PW+1bMoAwayIxg1kMKN3QADnqyxlVuW6SGVYEp+uWh0A9pHaZm/JorL7wj08vM8HcoFYkJhBjqvOSV1+RLJfDjmvWFFdbtKQTjKnKlKe1818Mp+neMkvlnTbZJMoHSnp+1EQ7e1XEDBBIHhA1U=
Message-ID: <9a8748490603061357v3fd2e4b7q7abc51f775108684@mail.gmail.com>
Date: Mon, 6 Mar 2006 22:57:06 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Dave Jones" <davej@redhat.com>, "Jesper Juhl" <jesper.juhl@gmail.com>,
       "Jens Axboe" <axboe@suse.de>, "Linus Torvalds" <torvalds@osdl.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>, markhe@nextd.demon.co.uk,
       "Andrea Arcangeli" <andrea@suse.de>,
       "Mike Christie" <michaelc@cs.wisc.edu>,
       "James Bottomley" <James.Bottomley@steeleye.com>
Subject: Re: Slab corruption in 2.6.16-rc5-mm2
In-Reply-To: <20060306215515.GE11565@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200603060117.16484.jesper.juhl@gmail.com>
	 <Pine.LNX.4.64.0603061122270.13139@g5.osdl.org>
	 <Pine.LNX.4.64.0603061147260.13139@g5.osdl.org>
	 <200603062124.42223.jesper.juhl@gmail.com>
	 <20060306203036.GQ4595@suse.de>
	 <9a8748490603061341l50febef9o3cb480bdbdcf925f@mail.gmail.com>
	 <20060306215515.GE11565@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/06, Dave Jones <davej@redhat.com> wrote:
> On Mon, Mar 06, 2006 at 10:41:07PM +0100, Jesper Juhl wrote:
>
>  > CONFIG_DEBUG_SLAB
>  > CONFIG_PAGE_OWNER
>  > CONFIG_DEBUG_VM
>  > CONFIG_DEBUG_PAGEALLOC
>  >
>  > The resulting kernel boots and runs just fine (no Oops) and leaves
>  > nothing in dmesg.
>  > So, without the debugging options it appears to the user that
>  > everything is OK - nasty.
>
> DEBUG_PAGEALLOC in particular is *fantastic* at making bugs hide.
> I've lost many an hour trying to pin bugs down due to that.
>

Well, in this case, turning the option *off* hides the bug ;)

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
