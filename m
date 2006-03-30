Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932218AbWC3ONc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbWC3ONc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 09:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbWC3ONc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 09:13:32 -0500
Received: from wproxy.gmail.com ([64.233.184.227]:45131 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932218AbWC3ONb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 09:13:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NKd5CcLTteHzsWvFZGgVkXNlkCBBlXtvkC69UcAQ+DCnYVDHA5N9169E9mMHcvoOt/O9wrcVC1Wj4qIxyrhM+ZvTN5EZKxCqwmy+TRbnjN3fzv5G+gTB4oD9PHVmr3H3Qk9JJ7IQbTJVnnnJ2Odl0yVwVkGwGLKFqHf5iAxHb1A=
Message-ID: <d120d5000603300613o3e5db188p521b766be075dfdc@mail.gmail.com>
Date: Thu, 30 Mar 2006 09:13:30 -0500
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Voluspa <lista1@telia.com>
Subject: Re: [2.6.16-gitX] PNP: No PS/2 controller found. Probing ports directly.
Cc: linux-kernel@vger.kernel.org, bjorn.helgaas@hp.com
In-Reply-To: <20060330125523.2b713a96.lista1@telia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060330125523.2b713a96.lista1@telia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/06, Voluspa <lista1@telia.com> wrote:
>
> Due to the commit:
>
> 982c609448b9d724e1c3a0d5aeee388c064479f0 is first bad commit
> diff-tree 982c609448b9d724e1c3a0d5aeee388c064479f0 (from 070c6999831dc4cfd9b07c74c2fea1964d7adfec)
> Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
> Date:   Mon Mar 27 01:17:08 2006 -0800
>
>    [PATCH] pnp: PNP: adjust pnp_register_driver signature
>

Does it help if you apply this patch:

http://www.kernel.org/git/?p=linux/kernel/git/dtor/input.git;a=commitdiff_plain;h=2bfc3c6e9516ece6856ec7904319650a5d4d9871;hp=dd55563f635751327eb06ae569d4761a0220f2e0

I am a bit slow with merging lately...

--
Dmitry
