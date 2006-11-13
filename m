Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755313AbWKMRRH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755313AbWKMRRH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 12:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755311AbWKMRRH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 12:17:07 -0500
Received: from wx-out-0506.google.com ([66.249.82.229]:40569 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1755316AbWKMRRE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 12:17:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=Oird7dXik0GjjtlAt25I8FaQTUebhWv4eWqXDSHOgAzn7mWGHtInaFInaRVlnLcbrIJ8msQvkKFtH0vrWByarExQPFj2jWv61L97rUX4AYLjZhSOOw+RSvp3TbO5q12JUcdM0M4wmnXK4ik6qMzauv//jTcetuBxz8ZYl2ZxHVo=
Message-ID: <eb97335b0611130917j18191c0ej3220b10c090d686f@mail.gmail.com>
Date: Mon, 13 Nov 2006 09:17:02 -0800
From: "Zack Weinberg" <zackw@panix.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Subject: Re: [patch 2/4] permission mapping for sys_syslog operations
Cc: "Chris Wright" <chrisw@sous-sol.org>,
       "Stephen Smalley" <sds@tycho.nsa.gov>, jmorris@namei.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1163411238.15249.114.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061113064043.264211000@panix.com>
	 <20061113064058.779558000@panix.com>
	 <1163409918.15249.111.camel@laptopd505.fenrus.org>
	 <eb97335b0611130129r7cdb8c8cuc8f2360e1f17f8f3@mail.gmail.com>
	 <1163411238.15249.114.camel@laptopd505.fenrus.org>
X-Google-Sender-Auth: 6d338f0e2667bc1a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/06, Arjan van de Ven <arjan@infradead.org> wrote:
> On Mon, 2006-11-13 at 01:29 -0800, Zack Weinberg wrote:
> > I thought the point of the "unifdef" thing was that it made a version
> > of the header with the __KERNEL__ section ripped out, for copying into
> > /usr/include, so you didn't have to do that ...
>
> yes it is, however it's mostly for existing stuff/seamless transition.
> It's a hack :)
> If you can avoid it lets do so; you already have the nice clean header,
> so lets not go backwards... you HAVE the clean separation.

ok, but I gotta ask that you tell me what to name the internal header,
I can't think of anything that isn't ugly.

zw
