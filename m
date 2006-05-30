Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932239AbWE3XtI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbWE3XtI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 19:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbWE3XtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 19:49:08 -0400
Received: from wr-out-0506.google.com ([64.233.184.231]:36852 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932239AbWE3XtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 19:49:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=I1gE0AN7Cpf3iMc0EuX7V8hTuGwRaliMy0U8wbrVkxhZAQrNvDWQ3M4s+EnA1Cx9CbkS5P/Er4iHBgNkDweduUsp+yyF+OjtHcR7YQ9jcdWCTjdahlCLZKcKCPuKVPAe5q2ql/SFMhYms53c2LT1xTC79d42MGeSI3QLUy13Q4g=
Message-ID: <6bffcb0e0605301649u2d3c48f5td9b7998168df8114@mail.gmail.com>
Date: Wed, 31 May 2006 01:49:04 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: 2.6.17-rc5-mm1
Cc: "Arjan van de Ven" <arjan@linux.intel.com>, linux-kernel@vger.kernel.org,
       "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <20060530230620.GA6226@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060530022925.8a67b613.akpm@osdl.org>
	 <6bffcb0e0605301155h3b472d79h65e8403e7fa0b214@mail.gmail.com>
	 <6bffcb0e0605301157o6b7c5f66q3c9f151cbb4537d5@mail.gmail.com>
	 <20060530194259.GB22742@elte.hu>
	 <6bffcb0e0605301457v9ba284bk75b8b6d14384489a@mail.gmail.com>
	 <20060530220931.GA32759@elte.hu>
	 <6bffcb0e0605301559y603a60bl685b7aca60069dfd@mail.gmail.com>
	 <20060530230512.GA6042@elte.hu> <20060530230620.GA6226@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/05/06, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Ingo Molnar <mingo@elte.hu> wrote:
>
> > Could you try the patch below? This uses the ID string as the key.
> > (the ID string seems to be based on static kernel strings most of the
> > time, so this might as well work)
>
> that patch should be:
>

Thanks, problem solved.

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
