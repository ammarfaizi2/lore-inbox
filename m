Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932439AbWJFW0d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932439AbWJFW0d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 18:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932652AbWJFW0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 18:26:33 -0400
Received: from wx-out-0506.google.com ([66.249.82.229]:29930 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932439AbWJFW0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 18:26:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XLgwDf+llx2gFgTHLIdmHYOEekZKn5c0Wj7xVt3SpZWUO0B70jBbUF4gvCj6mnv4FRBtrCgeC71IMlQhHYLHZzreQlwjOPUMkSqP4roHhaWcSzSKaPzLXn61v7IRBe1NdlQFIK++Pc9DhHo+/oUBITZZRYiFpoJsgV7poL23yTs=
Message-ID: <9a8748490610061526n5135f62ax81748f2175796a8c@mail.gmail.com>
Date: Sat, 7 Oct 2006 00:26:31 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Stas Sergeev" <stsp@aknet.ru>
Subject: Re: [patch] honour MNT_NOEXEC for access()
Cc: "Andrew Morton" <akpm@osdl.org>, "Jakub Jelinek" <jakub@redhat.com>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Linux kernel" <linux-kernel@vger.kernel.org>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Hugh Dickins" <hugh@veritas.com>,
       "Ulrich Drepper" <drepper@redhat.com>
In-Reply-To: <45269BEE.7050008@aknet.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4516B721.5070801@redhat.com>
	 <1159887682.2891.537.camel@laptopd505.fenrus.org>
	 <45229A99.6060703@aknet.ru>
	 <1159899820.2891.542.camel@laptopd505.fenrus.org>
	 <4522AEA1.5060304@aknet.ru>
	 <1159900934.2891.548.camel@laptopd505.fenrus.org>
	 <4522B4F9.8000301@aknet.ru>
	 <20061003210037.GO20982@devserv.devel.redhat.com>
	 <45240640.4070104@aknet.ru> <45269BEE.7050008@aknet.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/10/06, Stas Sergeev <stsp@aknet.ru> wrote:
> Hi Andrew.
>
> The attached patch makes the access(X_OK) to take the
> "noexec" mount option into an account.
>
Makes sense to me.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
