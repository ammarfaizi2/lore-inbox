Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030505AbWEZGHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030505AbWEZGHA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 02:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030507AbWEZGG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 02:06:59 -0400
Received: from wr-out-0506.google.com ([64.233.184.237]:52886 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030505AbWEZGG7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 02:06:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BWE1RqpbDUi1ry4A4DY6wynoKxG65MDxUE/GSUkt9v2+bb00i4fSwYlprL/Mn0jk6oshCRTx4zNtKQB8rUwweKylqVle7IEnS3Slw7qhfC4Y3reXBZPbno2f4d5lpyg/As2kly7xTcjdaFgRCztKATkufmZg6vIAuQ+Nyvj1LVc=
Message-ID: <4ae3c140605252306p4d4599c9g4e4e085a1b786144@mail.gmail.com>
Date: Fri, 26 May 2006 02:06:58 -0400
From: "Xin Zhao" <uszhaoxin@gmail.com>
To: "Neil Brown" <neilb@suse.de>
Subject: Re: why svc_export_lookup() has no implementation?
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
In-Reply-To: <17526.34136.986510.885941@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4ae3c140605252115n7b040a99l6633ba387ce48358@mail.gmail.com>
	 <17526.34136.986510.885941@cse.unsw.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks a lot! Neil. Now I know what happened. :)

Xin

On 5/26/06, Neil Brown <neilb@suse.de> wrote:
> On Friday May 26, uszhaoxin@gmail.com wrote:
> > I noticed that functions like exp_get_by_name() calls function
> > svc_export_lookup(). But I cannot find the implementation of
> > svc_export_lookup(). I can only find the function definition. HOw can
> > this happen?
> >
> > Can someone give me a hand?
>
> Look at and understand DefineCacheLookup (in
> include/linux/sunrpc/cache.h).
>
> Then look for places that it is used.
>
> But if you find you cannot stomach that, but assured that you aren't
> alone and have a look in something newer than 2.6.16.  There-in, and
> Randy has suggest, it will be easy to find the definition.
>
> NeilBrown
>
