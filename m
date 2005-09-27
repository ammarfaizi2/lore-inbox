Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750830AbVI0Dkm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbVI0Dkm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 23:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750832AbVI0Dkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 23:40:42 -0400
Received: from nproxy.gmail.com ([64.233.182.193]:45940 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750826AbVI0Dkl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 23:40:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TUrXWUeuMLX0XBrgMaubGBHTIqgwnSlwoJwhxHpqeNfavD7GlAaSDc/OtGElm8Q4VmPlJwN26QR8ftHG+qNphsJenJH3w2DNZ+3ytwxYCONI9lQiBWw/l0lbD/TDkQ1Iqp7fZhR4GPZw/o20HhkDBN11cXhtVqrdPUqw7P2H+Ps=
Message-ID: <2cd57c90050926204022fb22ca@mail.gmail.com>
Date: Tue, 27 Sep 2005 11:40:38 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: Coywolf Qi Hunt <coywolf@gmail.com>
To: Alex Williamson <alex.williamson@hp.com>
Subject: Re: [PATCH] sys_sendmsg() alignment bug fix
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <1127764921.6529.60.camel@tdi>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1127764921.6529.60.camel@tdi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/05, Alex Williamson <alex.williamson@hp.com> wrote:
>    The patch below adds an alignment attribute to the buffer used in
> sys_sendmsg().  This eliminates an unaligned access warning on ia64.

Is this a warning fix or bug fix?
--
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
