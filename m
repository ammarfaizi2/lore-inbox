Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261828AbVAMXu7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261828AbVAMXu7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 18:50:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261778AbVAMXuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 18:50:54 -0500
Received: from rproxy.gmail.com ([64.233.170.197]:55632 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261828AbVAMXuV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 18:50:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=ENNZzHYw7Vtzc6xwbcjK5ggMNZm8Ah9se/Bc8Kp3u1iaQrKxilhPmyzWQkN1bzsnF/a31FSD4Cn1iz2tWsJ8rEC/Y5mX/g+1EllyfR6h0jOxJQ48WYK12dHtzFvKoZYEDwJNgvG6FfoBzVZs47AmZlgJkwz1wCDPprQTnIkcymk=
Message-ID: <9e47339105011315503ceff3df@mail.gmail.com>
Date: Thu, 13 Jan 2005 18:50:16 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Luca Falavigna <dktrkranz@gmail.com>
Subject: Re: [BUG] Compile bug in Direct Rendering Manager (kernel 2.6.11-rc1)
Cc: dri-devel@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <41E6525E.6030200@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41E6525E.6030200@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jan 2005 11:50:06 +0100, Luca Falavigna <dktrkranz@gmail.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> While compiling kernel 2.6.11-rc1, make exits with a lot of errors concerning
> Direct Rendering Manager. Here is some info I've grabbed:

You have CONFIG_BROKEN turned on in your kernel .config. The gamma
driver is broken and it is marked as being broken. Turn off
CONFIG_BROKEN in your kernel config and it won't build.

-- 
Jon Smirl
jonsmirl@gmail.com
