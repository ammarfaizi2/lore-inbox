Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932483AbWH1JpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932483AbWH1JpX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 05:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932484AbWH1JpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 05:45:23 -0400
Received: from wx-out-0506.google.com ([66.249.82.233]:2086 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932483AbWH1JpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 05:45:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=M9dC94r+mdcK0DH/rEXRNncZb6ID6slbaDniflLC+rbbkXI9nv7qrpuXiaXWL/uIM7IpljwiqmTCFwYVhqzSmSncETj79bASquKyYTFnF5pPs/VDpV3AZRlqF25FrHJlM2FRYKo2/w2ZKKIkwnRyiwZ0kNbzRKV0d0ohIsjSVYI=
Message-ID: <9a8748490608280245n3228aaf0t99a50ad6f879e7e0@mail.gmail.com>
Date: Mon, 28 Aug 2006 11:45:21 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Christoph Hellwig" <hch@infradead.org>,
       "Richard Knutsson" <ricknu-0@student.ltu.se>,
       James.Bottomley@steeleye.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Conversion to generic boolean
In-Reply-To: <20060828093202.GC8980@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44EFBEFA.2010707@student.ltu.se>
	 <20060828093202.GC8980@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/08/06, Christoph Hellwig <hch@infradead.org> wrote:
> On Sat, Aug 26, 2006 at 05:24:42AM +0200, Richard Knutsson wrote:
> > Hello
> >
> > Just would like to ask if you want patches for:
>
> Total NACK to any of this boolean ididocy.  I very much hope you didn't
> get the impression you actually have a chance to get this merged.
>
> >
> > * (Most importent, may introduce bugs if left alone)
> > Fixing boolean checking, ex:
> > if (bool == FALSE)
> > to
> > if (!bool)
>
> this one of course makes sense, but please do it without introducing
> any boolean type.  Getting rid of all the TRUE/FALSE defines and converting
> all scsi drivers to classic C integer as boolean semantics would be
> very welcome janitorial work.
>
If you'll take such patches I'd be willing to clean up a few drivers..
 Any specific ones you'd like me to start with?

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
