Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261976AbVBBHwb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbVBBHwb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 02:52:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262082AbVBBHwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 02:52:31 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:41612 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261976AbVBBHwV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 02:52:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=suru5A6SS/uwhBMoZUpLp6BfvHtQBi14d5uyUEuuj65tPiyl2JppTBJPRNlJ2y9+P1CS6Zbe4AQohBm4gCA9zTV9UpSeHkDnJRrXM+WSbSM0nyyGTswQ8UM/QADk6Xd2Xqp3ERMWsKbh4VYoOk9z0/iL+AKDkgt/VXxUTenJVao=
Message-ID: <84144f02050201235257d0ec1c@mail.gmail.com>
Date: Wed, 2 Feb 2005 09:52:18 +0200
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: "pmarques@grupopie.com" <pmarques@grupopie.com>
Subject: Re: [PATCH 2.6] 4/7 replace uml_strdup by kstrdup
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, penberg@cs.helsinki.fi
In-Reply-To: <1107228511.41fef75f4a296@webmail.grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1107228511.41fef75f4a296@webmail.grupopie.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  1 Feb 2005 03:28:31 +0000, pmarques@grupopie.com
<pmarques@grupopie.com> wrote:
> diff -buprN -X dontdiff vanilla-2.6.11-rc2-bk9/arch/um/os-Linux/drivers/tuntap_user.c linux-2.6.11-rc2-bk9/arch/um/os-Linux/drivers/tuntap_user.c
> --- vanilla-2.6.11-rc2-bk9/arch/um/os-Linux/drivers/tuntap_user.c       2004-12-24 21:35:40.000000000 +0000
> +++ linux-2.6.11-rc2-bk9/arch/um/os-Linux/drivers/tuntap_user.c 2005-01-31 20:39:08.591154025 +0000

[snip]

> -               pri->dev_name = uml_strdup(buffer);
> +               pri->dev_name = kstrdup(buffer);

Please compile-test before submitting.

                           Pekka
