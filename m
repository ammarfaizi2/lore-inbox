Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261434AbVCHEnW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261434AbVCHEnW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 23:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261413AbVCHEnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 23:43:10 -0500
Received: from fire.osdl.org ([65.172.181.4]:12008 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261434AbVCHEll (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 23:41:41 -0500
Date: Mon, 7 Mar 2005 20:40:44 -0800
From: Andrew Morton <akpm@osdl.org>
To: Matt Mackall <mpm@selenic.com>
Cc: paul@linuxaudiosystems.com, joq@io.com, cfriesen@nortelnetworks.com,
       chrisw@osdl.org, hch@infradead.org, rlrevell@joe-job.com,
       arjanv@redhat.com, mingo@elte.hu, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-Id: <20050307204044.23e34019.akpm@osdl.org>
In-Reply-To: <20050308043349.GG3120@waste.org>
References: <20050112185258.GG2940@waste.org>
	<200501122116.j0CLGK3K022477@localhost.localdomain>
	<20050307195020.510a1ceb.akpm@osdl.org>
	<20050308043349.GG3120@waste.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> wrote:
>
> I think Chris Wright's last rlimit patch is more sensible and ready to
>  go.

I must say that I like rlimits - very straightforward, although somewhat
awkward to use from userspace due to shortsighted shell design.

Does anyone have serious objections to this approach?
