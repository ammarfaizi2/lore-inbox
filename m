Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751134AbWHGV7x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbWHGV7x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 17:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbWHGV7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 17:59:53 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:29747 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751134AbWHGV7w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 17:59:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PgFxbqKPYF6sgtDh01GnsGkbsp/SftvRbB2Us7/KS5g72ZFSJZfCep0LkU5m2OXXt6uW38l9Tanawl/WYgHbVWx8kYVPaybwDq/LxYqS4dqJxfKjcUbIZyYKZIzeFdAkhHuSycGLuNlOfMTLnTWGVbzxksp0CEr5xNANXOZggLU=
Message-ID: <a762e240608071459x175eba48j953a202a8374e55@mail.gmail.com>
Date: Mon, 7 Aug 2006 14:59:51 -0700
From: "Keith Mannthey" <kmannth@gmail.com>
To: "Andy Whitcroft" <apw@shadowen.org>
Subject: Re: [PATCH] x86_64 dirty fix to restore dual command line store
Cc: "Andrew Morton" <akpm@osdl.org>, "Andi Keen" <ak@suse.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <a762e240608071447n61c0c421qa923df6eea9f151d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44D75691.8070908@shadowen.org>
	 <20060807151216.GA15194@shadowen.org>
	 <a762e240608071447n61c0c421qa923df6eea9f151d@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/06, Keith Mannthey <kmannth@gmail.com> wrote:
> On 8/7/06, Andy Whitcroft <apw@shadowen.org> wrote:
> > x86_64 dirty fix to restore dual command line store
> >
> > Ok, It seems that the patch below effectivly removes the second
> > copy of the command line.  This means that any modification to the
> > 'working' command line (as returned from setup_arch) is incorrectly
> > visible in userspace via /proc/cmdline.
>
> Sorry for the side question but why is setup_arch adding things back
> on the cmdline in the first place?  What do you see in /proc/cmdline?

Sorry for the ping.  I read some more lkml and the context for this
patch was filled in.

Thanks,
  Keith
