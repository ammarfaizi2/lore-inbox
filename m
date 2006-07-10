Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161091AbWGJNDc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161091AbWGJNDc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 09:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161090AbWGJNDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 09:03:32 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:5986 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161065AbWGJNDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 09:03:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PPcN9mM3UEm36mUKAreLoEWKfzAVM04YA1/VOYXEyLKeG9ohufE87xlLPHYtTcHWmGMuXQLoZYsW/Viy1se9Csm4Aa+cs04FgJCZGi4J8JEid19n3ab4SR+gDc1lz2PFjn1OSMr1gsSBaO8/MQ32D+EwiD17mtojVMSFfczN+ZQ=
Message-ID: <d120d5000607100603r7ac59457tc1b080a15ed84db3@mail.gmail.com>
Date: Mon, 10 Jul 2006 09:03:29 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Subject: Re: [RFC][PATCH 0/9] -Wshadow: Making the kernel build clean with -Wshadow
Cc: "Jesper Juhl" <jesper.juhl@gmail.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <1152535999.4874.36.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9a8748490607100548o14dbe684j40bde90eb19a7558@mail.gmail.com>
	 <1152535999.4874.36.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/06, Arjan van de Ven <arjan@infradead.org> wrote:
>
> > So, what do people say?
>
>
> Hi,
>
> I'm just about always in favor of having automated tools help us find
> bugs. However... can you give an indication of how many real bugs you
> have encountered? If it's "mostly noise" all the time.. then it's maybe
> not worth the effort... while if you find real bugs then it's obviously
> worthwhile to go through this.
>

While we may not have any issues with the present code it can help
avoiding problems in new code if we have -Wshadow by default.

Just my $.02

-- 
Dmitry
