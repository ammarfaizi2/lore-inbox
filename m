Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261861AbVGaKFC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261861AbVGaKFC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 06:05:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263193AbVGaKFC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 06:05:02 -0400
Received: from nproxy.gmail.com ([64.233.182.198]:36494 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261861AbVGaKFA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 06:05:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MiM6QKsX7XlQtGWp7FYoj/TOxNKs0wG3g8L+/8VxPgzi7BMiJyjyZj0sI1MHf0ExvcmYpvLnwLxaNNjmVGWK8phgdFyxqgB4ZNmeKF00Ts2K3J/aqLAc7FR5k6Ue5IwLZQOptA12rlJu9ZoYgq32/krDpaCJBy3HYtZdSn683m4=
Message-ID: <6f6293f105073103045fd32d61@mail.gmail.com>
Date: Sun, 31 Jul 2005 12:04:59 +0200
From: Felipe Alfaro Solana <felipe.alfaro@gmail.com>
Reply-To: Felipe Alfaro Solana <felipe.alfaro@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.13-rc4-mm1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050731020552.72623ad4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050731020552.72623ad4.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc4/2.6.13-rc4-mm1/

Why was the KERNEL_VERSION(a,b,c) macro removed from
include/linux/version.h? The removal breaks external drivers like
NDISWRAPPER or nVidia propietary.
