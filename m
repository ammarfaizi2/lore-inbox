Return-Path: <linux-kernel-owner+w=401wt.eu-S1751292AbWLLM4i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbWLLM4i (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 07:56:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbWLLM4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 07:56:38 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:24934 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293AbWLLM4h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 07:56:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UrZbSY+JmCt1b/3aztjdUa//RYSJCSFd1D5grE3I1EkdojlGLXKcI8Ba/f/aNVpIwHkJ1eWYbdBW9fucbcGc1+Wm9kKorrTZG3DDKx+KaEQFUB4LamZ2P3DQ1XBoGxMLztS1ESiDn3agv1JIQaOGqr1U6F2PRjiEpdh/mMuFbfE=
Message-ID: <625fc13d0612120456p1d74663fp21e40ee84a8819bc@mail.gmail.com>
Date: Tue, 12 Dec 2006 06:56:35 -0600
From: "Josh Boyer" <jwboyer@gmail.com>
To: "Jeff Garzik" <jeff@garzik.org>
Subject: Re: [PATCH/RFC] Delete JFFS (version 1)
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org, "Andrew Morton" <akpm@osdl.org>,
       jffs-dev@axis.com, "David Woodhouse" <dwmw2@infradead.org>
In-Reply-To: <457EA2FE.3050206@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <457EA2FE.3050206@garzik.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/06, Jeff Garzik <jeff@garzik.org> wrote:
> I have created the 'kill-jffs' branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/misc-2.6.git that
> removes fs/jffs.
>
> I argue that you can count the users (who aren't on 2.4) on one hand,
> and developers don't seem to have cared for it in ages.
>
> People are already talking about jffs2 replacements, so I propose we zap
> jffs in 2.6.21.

I'm usually all for killing broken code, but JFFS isn't really broken
is it?  Is there some burden it's causing by being in the kernel at
the moment?

josh
