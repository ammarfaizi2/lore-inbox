Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422643AbWGJOv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422643AbWGJOv6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 10:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422644AbWGJOv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 10:51:58 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:40968 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1422643AbWGJOv5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 10:51:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=izCY9IL4w7zBTf9njJDTX5f49NS6EGB7ybrC11rqLtaHX/sbC2QEAkxw55sWor+gnww2IAinjRv/JK4QkeON2uF7A/OuyaSsTOa6ec0CZAjs+N/MwDXWi1eaRoQH1GVDBX00D9jYWCxKjKm6TWTwzliQfbcrrEkgUEIQYbJ2mQU=
Message-ID: <9a8748490607100751o512003ecsef920e420d27f605@mail.gmail.com>
Date: Mon, 10 Jul 2006 16:51:56 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Christoph Hellwig" <hch@infradead.org>,
       "Jesper Juhl" <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 5/9] -Wshadow: variables named 'up' clash with up()
In-Reply-To: <20060710145056.GA549@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200607101313.04275.jesper.juhl@gmail.com>
	 <20060710145056.GA549@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/06, Christoph Hellwig <hch@infradead.org> wrote:
> > -static inline void uid_hash_insert(struct user_struct *up, struct list_head *hashent)
> > +static inline void uid_hash_insert(struct user_struct *_up, struct list_head *hashent)
> >  {
>
> Please never use such ugly names.  A simply 'u' as variable name would do it
> instead in most places.
>
Ok, will do.
Thank you for the feedback.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
