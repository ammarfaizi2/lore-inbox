Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161040AbWBUWSF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161040AbWBUWSF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 17:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161114AbWBUWSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 17:18:05 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:30147 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161040AbWBUWSB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 17:18:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nnO0DWAwjo+/aJ8u80dz4Q9+SXDGYOcqRZX7EEjIsuDpf65XvpmMVYd7N+Rc94seROQAo337TUfth97MJIaucy8rgRBNfJfCv1yzJcEC2PYeNMNrsRYxq6oviFSlh3RFth5cTEqHHmlxqlypfVVbQigwm/D7p1Q3FwYoZ3a0nvo=
Message-ID: <9a8748490602211418y7f9c6cf8yb93dff8e200669e5@mail.gmail.com>
Date: Tue, 21 Feb 2006 23:18:00 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Sam Ravnborg" <sam@ravnborg.org>
Subject: Re: make -j with j <= 4 seems to only load a single CPU core
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <20060221221517.GA9629@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9a8748490602211302j61c0088fp8b555860e928028e@mail.gmail.com>
	 <9a8748490602211310j344db10evd685149a3c60b1e7@mail.gmail.com>
	 <20060221221517.GA9629@mars.ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/06, Sam Ravnborg <sam@ravnborg.org> wrote:
> On Tue, Feb 21, 2006 at 10:10:46PM +0100, Jesper Juhl wrote:
> > On 2/21/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> > > This is quite odd and I've no idea where to start looking for the
> > > cause, but let me describe what I'm seeing and maybe someone can point
> > > me in the right direction.
> > >
> > > I'm running SMP 2.6.x kernels on a Athlon 64 X2 4400+
> > >
> >
> > I should probably mention that the kernel I'm currently running and
> > observing this behaviour with is 2.6.16-rc4-mm1.
>
> Hi Jesper.
> Could you please double check that patch below has been applied to your
> tree.
>

Hi Sam,

I just checked and that patch is indeed in the tree I'm building
(which is also the one I'm running).

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
