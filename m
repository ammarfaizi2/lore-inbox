Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965225AbWEOVHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965225AbWEOVHA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 17:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965227AbWEOVG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 17:06:59 -0400
Received: from mx.pathscale.com ([64.160.42.68]:14724 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S965225AbWEOVG7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 17:06:59 -0400
Subject: Re: [PATCH 4 of 53] ipath - cap number of PDs that can be allocated
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
In-Reply-To: <adapsifuw9e.fsf@cisco.com>
References: <300f0aa6f034eec6a806.1147477369@eng-12.pathscale.com>
	 <adapsifuw9e.fsf@cisco.com>
Content-Type: text/plain
Date: Mon, 15 May 2006 14:06:57 -0700
Message-Id: <1147727217.2773.6.camel@chalcedony.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-15 at 08:45 -0700, Roland Dreier wrote:

> Would it make more sense to fix the stress test?

I don't think so.  Without some kind of limits, it is simple for an
unprivileged user process to cause the kernel to allocate huge wads of
memory and thereby DoS or accidentally OOM the machine.

The test in question should probably be fixed, but this is a much more
fundamental problem.  I don't have any specific opinions on what should
be done about it, other than "something".

	<b

