Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932129AbVKGPEL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbVKGPEL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 10:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbVKGPEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 10:04:11 -0500
Received: from zproxy.gmail.com ([64.233.162.192]:52589 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932129AbVKGPEK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 10:04:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=f22pLqsAtSfiDz6CrRwZrkrYcoJHUsFYdfIKp8SAC3PX98RiwObVcaHgHdfHaU4jZE5GhfFP5JA8fiqu9WEPHz/sjtJjdd4Y/ATZHzMxV/49KOL1nqcNECtIfNLDJycNLutOlhhCZ0NLM1iJMiXkwp3aaA7dNrmIqSebtZT9fUI=
Message-ID: <d9c105ea0511070704k309b7563q8a17302bc99a514c@mail.gmail.com>
Date: Mon, 7 Nov 2005 09:04:09 -0600
From: Dustin Kirkland <dustin.kirkland@gmail.com>
To: Jiri Slaby <xslaby@fi.muni.cz>
Subject: Re: 2.6.14-mm1
Cc: Andrew Morton <akpm@osdl.org>, linux-audit@redhat.com, dwmw2@infradead.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051107120012.48D7C22AF77@anxur.fi.muni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051106182447.5f571a46.akpm@osdl.org>
	 <20051107120012.48D7C22AF77@anxur.fi.muni.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/05, Jiri Slaby <xslaby@fi.muni.cz> wrote:
> Andrew Morton wrote:
> >Changes since 2.6.14-rc5-mm1:
> >
> [...]
> > git-audit.patch
> There are many errors produced by this patch. I don't have any security model
> enabled and in audit_ipc_context security_ipc_getsecurity returns -EOPNOTSUPP,
> that causes audit_panic("error in audit_ipc_context");

Jiri-

This is probably related to some code that I've been working with
David on.  If I could get a little more information from you, I'd like
to reproduce this and fix it properly.

Do I understand you properly that your kernel is compiled with AUDIT
on and SELINUX off?

Thanks,
:-Dustin
