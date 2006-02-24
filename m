Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932642AbWBXXUM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932642AbWBXXUM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 18:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932643AbWBXXUM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 18:20:12 -0500
Received: from zproxy.gmail.com ([64.233.162.206]:43760 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932642AbWBXXUK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 18:20:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aXFsmWImFniypXptxRzWShSAnvq0F9OscMvzHWEaNUEkxhaFDo977OSUC91pU7/jGFzI9xaA9oO5HgdzXybDx4pim/JZ/XdbzaKimMFmEikCNxd+RR5w6ZwP+f2RfCEEGXxDElRSqEMBEZOv+IjASvnLHbqOpAw9euDcSL+3ngY=
Message-ID: <9a8748490602241520u4b09bef0p34feffc3ecebed31@mail.gmail.com>
Date: Sat, 25 Feb 2006 00:20:09 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Al Viro" <viro@ftp.linux.org.uk>
Subject: Re: [PATCH 12/13] "const static" vs "static const" in nfs4
Cc: "Trond Myklebust" <trond.myklebust@fys.uio.no>,
       "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Kendrick Smith" <kmsmith@umich.edu>, "Andy Adamson" <andros@umich.edu>,
       neilb@cse.unsw.edu.au
In-Reply-To: <20060224231749.GH27946@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200602242149.42735.jesper.juhl@gmail.com>
	 <1140821964.3615.95.camel@lade.trondhjem.org>
	 <9a8748490602241501q550488baqad63df65f4dd8623@mail.gmail.com>
	 <20060224231749.GH27946@ftp.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/06, Al Viro <viro@ftp.linux.org.uk> wrote:
> On Sat, Feb 25, 2006 at 12:01:32AM +0100, Jesper Juhl wrote:
> > No need for that. It's just something that ICC complains about
> > "storage class not being first" - gcc doesn't care.
>
> Neither does C99, so ICC really should either STFU or make that warning
> independent from the rest and possible to turn off...
>

I agree.

But, it's harmless to change, and a patch is already in mainline a
while back that changes all occourences except this one (i simly
forgot one), so might as well get the last one and then it's a
non-issue.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
