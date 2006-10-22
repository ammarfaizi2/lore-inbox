Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751416AbWJVUXD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbWJVUXD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 16:23:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbWJVUXD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 16:23:03 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:13112 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751416AbWJVUXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 16:23:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=bikRTHksSFpukSI1L8+7X6QFB6v2j7fQFWB39vSaTNiAHRkl4RxIHbFZ8BWRRUgxlCnrIv9sYCZrFaML34TBnVVdvnbwXphswat5xpHsa8u2mp6bM/jRZOi+46777FJ5fsaFnR4D0MhDXDfo9aXfYODimxZ+rmCNkBktINUMtxA=
Message-ID: <84144f020610221322v2683a66bmf837ada1edea72e0@mail.gmail.com>
Date: Sun, 22 Oct 2006 23:22:59 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Amit Choudhary" <amit2030@yahoo.com>
Subject: Re: Hopefully, kmalloc() will always succeed, but if it doesn't then....
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061022195809.30126.qmail@web55607.mail.re4.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061022195809.30126.qmail@web55607.mail.re4.yahoo.com>
X-Google-Sender-Auth: 5a305f21760d5933
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/06, Amit Choudhary <amit2030@yahoo.com> wrote:
> So, if memory allocation to 'a' fails, it is going to kfree 'b'. But since 'b'
> is not initialized, kfree may crash (unless DEBUG is defined).
>
> I have seen the same case at many places when allocating in a loop.

So you found a bug. Why not send a patch to fix it?
