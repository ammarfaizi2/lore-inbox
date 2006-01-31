Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbWAaIy1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbWAaIy1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 03:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750709AbWAaIy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 03:54:27 -0500
Received: from zproxy.gmail.com ([64.233.162.200]:11570 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750708AbWAaIy1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 03:54:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LfZQdY2yhf5EH+cGIWzHe/+1cyZw5sZ/tMT7a9+4/2CtEMDxXfAFBKms9i5sMrC5omHF/fEkD/Y/ulodSF6ECBEI0tlpkoNoOc2QfV5HaP0JtiA+RzdSuL4bKHktnXE6Uh5CxXWYJKnU+rrAiYcWeTF9mRiwNFgM8Xy+Y7IpyI0=
Message-ID: <9a8748490601310054w19e0fa1foc0cb8c65e337aadf@mail.gmail.com>
Date: Tue, 31 Jan 2006 09:54:26 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "L. A. Walsh" <lkml@tlinx.org>
Subject: Re: i386 requires x86_64?
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <43DED532.5060407@tlinx.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43DED532.5060407@tlinx.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/06, L. A. Walsh <lkml@tlinx.org> wrote:
> Generating a new kernel and wanted to delete the unrelated architectures.
>

Why bother deleting parts of the code?
The kernel you build will only contain code for the architecture you
build for anyway. Sure, the extra source takes up a little space on
disk but if that bothers you you could just delete (or tar+bzip2) the
entire source tree after you build and install your new kernel.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
