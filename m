Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965243AbWCTPqw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965243AbWCTPqw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:46:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965431AbWCTPqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:46:51 -0500
Received: from nproxy.gmail.com ([64.233.182.202]:6278 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965427AbWCTPqa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:46:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NxgtVfx9+NqShM+nQ/4+8qjlzh86b39y9XHuIJVSntlmxYGMEZXuYjZ1NR3aLTo6RhMihWbCHAk2PR5TELxWiABYA7JVELnJPehgbymrC8rplFYX4SgxgMdCsAvZluoHz3D2tD024LKRMbzHArCT+P8ZITCYHXswwGK7sI+KUJI=
Message-ID: <b6c5339f0603200746k3e817e9bmdc278764fe488a8c@mail.gmail.com>
Date: Mon, 20 Mar 2006 10:46:27 -0500
From: "Bob Copeland" <me@bobcopeland.com>
To: "Benjamin Bach" <benjamin@overtag.dk>
Subject: Re: Idea: Automatic binary driver compiling system
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <441D82D8.7050106@overtag.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <441AF93C.6040407@overtag.dk> <1142620509.25258.53.camel@mindpipe>
	 <441C213A.3000404@overtag.dk>
	 <1142694655.2889.22.camel@laptopd505.fenrus.org>
	 <441C2CF6.1050607@overtag.dk>
	 <1142698292.2889.26.camel@laptopd505.fenrus.org>
	 <441D36DA.2000701@overtag.dk>
	 <b6c5339f0603190719u6e52ba3cwda15509de3ed947e@mail.gmail.com>
	 <441D82D8.7050106@overtag.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/19/06, Benjamin Bach <benjamin@overtag.dk> wrote:
> Otherwise I'll probably dig up something. Just needs to be a small
> kernel-whatever project.
>
> Is there someone maintaining a list of non-implemented ideas for kernel
> features/drivers?

Although neither of these are easy and you very well might not get
anything done in three months, a couple of bits of hardware that I
have for which there are incomplete/no drivers, and where the
manufacturer refuses to give out specs are:

- Ricoh MMC/SD controllers.  The project to figure those out is at:
http://mmc.drzeus.cx/wiki/Controllers/Ricoh/Frontreport

- 3D for NVidia.  I know many people would take an open but basic 3D
driver over the fully featured binary one - many people already use
the 2D 'nv' driver for that reason.  Rudolf Cornelissen has reverse
engineered various bits of it (though it may apply only to the
geforce-1 era cards) over here:
http://web.inter.nl.net/users/be-hold/BeOS/NVdriver/3dnews.html

You will find it's a whole lot easier to write drivers when you have
specs though, and the resulting drivers will also be better.  But
depending on the scope of your project, you could definitely learn
something either way.

Another thing that would be a lot easier to accomplish in 3 months
would be to write a userspace filesystem using FUSE for something that
isn't ordinarily accessed by filesystems; for example currently you
can mount remote machines over ssh, cameras that can talk to gphoto,
tar archives, gmail, etc.
