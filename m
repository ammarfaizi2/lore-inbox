Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262391AbUK3WrD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262391AbUK3WrD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 17:47:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262382AbUK3WrC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 17:47:02 -0500
Received: from box.punkt.pl ([217.8.180.66]:46602 "HELO box.punkt.pl")
	by vger.kernel.org with SMTP id S262387AbUK3Wqg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 17:46:36 -0500
From: Mariusz Mazur <mmazur@kernel.pl>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Date: Tue, 30 Nov 2004 23:44:21 +0100
User-Agent: KMail/1.7
Cc: Linus Torvalds <torvalds@osdl.org>, David Woodhouse <dwmw2@infradead.org>,
       Alexandre Oliva <aoliva@redhat.com>, Paul Mackerras <paulus@samba.org>,
       Greg KH <greg@kroah.com>, Matthew Wilcox <matthew@wil.cx>,
       David Howells <dhowells@redhat.com>, hch@infradead.org,
       linux-kernel@vger.kernel.org, libc-hacker@sources.redhat.com
References: <19865.1101395592@redhat.com> <Pine.LNX.4.58.0411301243000.22796@ppc970.osdl.org> <20041130223359.GA15443@mars.ravnborg.org>
In-Reply-To: <20041130223359.GA15443@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411302344.21907.mmazur@kernel.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On wtorek 30 listopad 2004 23:33, Sam Ravnborg wrote:
> On Tue, Nov 30, 2004 at 12:47:50PM -0800, Linus Torvalds wrote:
>  If that's all that people want, I hereby proclaim that
>
> >  include/asm-xxx/user/xxxx.h
> >  include/user/xxxx.h
> >
> > is reserved for user-visible stuff. And now you can send me small and
> > localized patches that fix a _particular_ gripe.
>
> Please use:
>   include/$arch/user-asm/xxxx.h
>   include/user/xxxx.h

Wrong. These dirs must be linked to /usr/include so they must have more 
meaningfull names.

-- 
In the year eighty five ten
God is gonna shake his mighty head
He'll either say,
"I'm pleased where man has been"
Or tear it down, and start again
