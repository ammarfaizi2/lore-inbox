Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751430AbWBQOSu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430AbWBQOSu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 09:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750AbWBQOSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 09:18:50 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:55696 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751425AbWBQOSs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 09:18:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eCkBmq3Qo+24doqpuDxQt3yuNOF862vFYwNs5y/H2yqyIXh9tgfpg5z+SAJpWU6hOBnVfuM8rQYPiOomf5bHoS7M75n+8bG882pyqPptYZPwssHCQOqu4xE1pLFIVBhT2vGzX8GxOOcSWs9Ju2bMPAhlBsNr9s4YTxALvD3M3Vc=
Message-ID: <3b0ffc1f0602170618u7a1ad877s337de33c0a8f44f9@mail.gmail.com>
Date: Fri, 17 Feb 2006 09:18:47 -0500
From: Kevin Radloff <radsaq@gmail.com>
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: [ck] [PATCH] mm: implement swap prefetching (v26)
Cc: Andrew Morton <akpm@osdl.org>, ck list <ck@vds.kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <200602172235.40019.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200602172235.40019.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/17/06, Con Kolivas <kernel@kolivas.org> wrote:
> Added disabling of swap prefetching when laptop_mode is enabled.

Why bother with this? As someone commented in a previous thread,
wouldn't it be better to let the laptop_mode script handle it?

--
Kevin 'radsaq' Radloff
radsaq@gmail.com
http://thesaq.com/
