Return-Path: <linux-kernel-owner+w=401wt.eu-S964889AbWLOU4v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964889AbWLOU4v (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 15:56:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964893AbWLOU4v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 15:56:51 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:58974 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964889AbWLOU4u convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 15:56:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EzTUAF5obm79NEQQSskU/NPvSeSHJRlg88ljlB5MnSXK5YL43pEr96/2aIo9MF3/4FxxWuLCv9W50Z82W1zpi91bGG8sS0GCH99cJjunAF9ZkqQCUbCDvWwxH71PXKhraKrBNcK/pmVTaOaDbZOaONe9mOutof4QQ1irwAnPINg=
Message-ID: <d120d5000612151256h5428eddcpbd137ce939a58b32@mail.gmail.com>
Date: Fri, 15 Dec 2006 15:56:46 -0500
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "=?ISO-8859-1?Q?J=F6rn_Engel?=" <joern@lazybastard.org>
Subject: Re: [PATCH/v2] CodingStyle updates
Cc: "Randy Dunlap" <randy.dunlap@oracle.com>, "Pavel Machek" <pavel@ucw.cz>,
       "Scott Preece" <sepreece@gmail.com>,
       "kernel list" <linux-kernel@vger.kernel.org>
In-Reply-To: <20061215201127.GA32210@lazybastard.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <20061207165508.e6bf0269.randy.dunlap@oracle.com>
	 <20061215120942.GA4551@ucw.cz> <4582AEC8.7030608@s5r6.in-berlin.de>
	 <20061215142206.GC2053@elf.ucw.cz>
	 <7b69d1470612150652p609c38d2n9bff58bdb0a1edb7@mail.gmail.com>
	 <20061215150717.GA2345@elf.ucw.cz>
	 <20061215090037.05c021af.randy.dunlap@oracle.com>
	 <20061215201127.GA32210@lazybastard.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/15/06, Jörn Engel <joern@lazybastard.org> wrote:
> On Fri, 15 December 2006 09:00:37 -0800, Randy Dunlap wrote:
> > On Fri, 15 Dec 2006 16:07:17 +0100 Pavel Machek wrote:
> >
> > > Not in simple cases.
> > >
> > >     3*i + 2*j should be writen like that. Not like
> > >     (3 * i) + (2 * j)
> >
> > I would just write it as:
> >       3 * i + 2 * j
>
> So would I.  But I definitely wouldn't write
>        for (i = 0; i < 10; i += 2)
> because I prefer the grouping in
>        for (i=0; i<10; i+=2)
>

Would you write:

       i+=2;

outside the loop? If not then it is better to keep style consistent
and not use condensed form in loops either.

-- 
Dmitry
