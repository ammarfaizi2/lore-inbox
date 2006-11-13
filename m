Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754328AbWKMJ3q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754328AbWKMJ3q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 04:29:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754333AbWKMJ3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 04:29:46 -0500
Received: from wx-out-0506.google.com ([66.249.82.238]:2405 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1754308AbWKMJ3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 04:29:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=ST501W7bIzXBZFaqBgnWUBqBEdWa9fP34gUEaWOeKRvNc4jwOZSKylM8JyeLykPTW+kjGWD06i6ip94ezGT3aUevhRNdYhht6SrYrOEmbU9N6dovNfALVN/benfLT1gLFwmJveaCyjVeR/Xaz0MqWFH/XamvQ4ldGEvXPw0SVlw=
Message-ID: <eb97335b0611130129r7cdb8c8cuc8f2360e1f17f8f3@mail.gmail.com>
Date: Mon, 13 Nov 2006 01:29:43 -0800
From: "Zack Weinberg" <zackw@panix.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Subject: Re: [patch 2/4] permission mapping for sys_syslog operations
Cc: "Chris Wright" <chrisw@sous-sol.org>,
       "Stephen Smalley" <sds@tycho.nsa.gov>, jmorris@namei.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1163409918.15249.111.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061113064043.264211000@panix.com>
	 <20061113064058.779558000@panix.com>
	 <1163409918.15249.111.camel@laptopd505.fenrus.org>
X-Google-Sender-Auth: 2d69708f6e78fa17
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/06, Arjan van de Ven <arjan@infradead.org> wrote:
> you had such a nice userspace/kernel shared header.. and now you mix it
> with kernel privates again... can you consider making this a second
> header?

I thought the point of the "unifdef" thing was that it made a version
of the header with the __KERNEL__ section ripped out, for copying into
/usr/include, so you didn't have to do that ...

zw
