Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261321AbUE0ExQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbUE0ExQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 00:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbUE0ExQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 00:53:16 -0400
Received: from mx4.cs.washington.edu ([128.208.4.190]:27360 "EHLO
	mx4.cs.washington.edu") by vger.kernel.org with ESMTP
	id S261321AbUE0ExP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 00:53:15 -0400
Date: Wed, 26 May 2004 21:53:14 -0700 (PDT)
From: Vadim Lobanov <vadim@cs.washington.edu>
To: linux-kernel@vger.kernel.org
Subject: epoll question
Message-ID: <20040526214852.I23529-100000@attu3.cs.washington.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a quick question about the behavior of epoll. My usage scenario is 
as follows:

I add multiple fd's to the epoll set. Some of the fd's will have a lot of 
data coming in, while others will have noticeably less.
I start to epoll for events, only letting it return one event at a time

In this case, will the lesser-active fd's be starved out by the 
constantly-active fd's, or will they still be reliably seen?

-Vadim Lobanov

