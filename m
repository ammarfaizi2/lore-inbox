Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756405AbWK0Dfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756405AbWK0Dfi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 22:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756406AbWK0Dfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 22:35:38 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:61596 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1756395AbWK0Dfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 22:35:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=f+BUwLd4JXMPbeXbx9XK3ndAwiJr/ZQPWRWmFfDCspyx8PQiay3ELpqNlgI2uqB5IbsWTi5ZYuQttrim3n9eLXg7xv4pxLLK8ieuMPgERpXQD+Vo2m+11FPxvZsLb2dSmjBZr7Rh3hErxsEzh5btbmZMl7MXGS6WWOS8KBpD8n0=
Message-ID: <86802c440611261935n1ca52a28m73a194a05431b488@mail.gmail.com>
Date: Sun, 26 Nov 2006 19:35:35 -0800
From: "Yinghai Lu" <yinghai.lu@amd.com>
To: "Andi Kleen" <ak@muc.de>
Subject: Re: [PATCH 2/3] x86: remove duplicated parser for "pci=noacpi"
Cc: "Andrew Morton" <akpm@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061127002221.GA57506@muc.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <86802c440611261523q4bbd4fbbob5dd36db12dd9a01@mail.gmail.com>
	 <20061127002221.GA57506@muc.de>
X-Google-Sender-Auth: 8f3efe594d24f099
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Nov 2006 01:22:21 +0100, Andi Kleen <ak@muc.de> wrote:
> On Sun, Nov 26, 2006 at 03:23:36PM -0800, Yinghai Lu wrote:
> >
>
> Are you sure it's correct? The drivers/pci pci= parsing
> isn't early and there tend to be nasty ordering issues.
> I can't see where it would go wrong here, but it probably
> needs very careful double checking.

I will double check that

YH
