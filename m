Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261625AbVGIRJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261625AbVGIRJv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 13:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261619AbVGIRJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 13:09:46 -0400
Received: from nproxy.gmail.com ([64.233.182.192]:57032 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261622AbVGIRJ2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 13:09:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=c+zCqK3nfvn6eaGIR3dXDDR1Lft/+oqsysXi7mMSEWSy1Z7sBV1u9/+Onmf/j063pzYJb0kahFBLM8L0RkWA9keJ0Vf0BDmzMnjfv1+5VjtUjrnUh7xs/HoMBhcHJCpWJkWy6297zKwQ7qYahUc66uLla48b7p605mHOitgLYH0=
Message-ID: <2cd57c9005070910091f1051f7@mail.gmail.com>
Date: Sun, 10 Jul 2005 01:09:22 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: coywolf@lovecn.org
To: Nico Schottelius <nico-kernel@schottelius.org>,
       linux-kernel@vger.kernel.org
Subject: Re: halt: init exits/panic
In-Reply-To: <20050709151227.GM1322@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050709151227.GM1322@schottelius.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/9/05, Nico Schottelius <nico-kernel@schottelius.org> wrote:
> Hello!
> 
> What's the 'correct behaviour' of an init system, if someone wants
> to shutdown the system?
> 
> I currently do:
> 
> - call reboot(RB_POWER_OFF/RB_AUTOBOOT/RB_HALT_SYSTEM)
> - _exit(0)
> 
> Is this exit() call wrong? If I do RB_HALT_SYSTEM and _exit(0) after,
> the kernel panics.

What the panic shows?
-- 
Coywolf Qi Hunt
http://ahbl.org/~coywolf/
