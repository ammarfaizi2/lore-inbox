Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318253AbSHZUVD>; Mon, 26 Aug 2002 16:21:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318255AbSHZUVD>; Mon, 26 Aug 2002 16:21:03 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:53509
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S318253AbSHZUVC>; Mon, 26 Aug 2002 16:21:02 -0400
Subject: Re: [PATCH] hyperthreading scheduler improvement
From: Robert Love <rml@tech9.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1030392908.2776.17.camel@irongate.swansea.linux.org.uk>
References: <1030392337.15007.413.camel@phantasy> 
	<1030392908.2776.17.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 26 Aug 2002 16:25:11 -0400
Message-Id: <1030393512.15007.435.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-26 at 16:15, Alan Cox wrote:

> This patch is disabled in -ac because it caused crashes for some users

I noticed - I actually got around to doing these patches because I was
trying to find a solution to that problem. :)

Do you think it could be some odd behavior on non-P4 x86 SMP systems? 
Maybe sparse CPU ids?

At least for now, this 2.5 patch is P4-only.

	Robert Love

