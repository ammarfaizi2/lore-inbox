Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317998AbSGLVKf>; Fri, 12 Jul 2002 17:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317999AbSGLVKf>; Fri, 12 Jul 2002 17:10:35 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:63217 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317998AbSGLVKd>; Fri, 12 Jul 2002 17:10:33 -0400
Subject: Re: MAP_NORESERVE with MAP_SHARED
From: Robert Love <rml@tech9.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: davidm@hpl.hp.com, linux-kernel@vger.kernel.org
In-Reply-To: <1026512102.9915.22.camel@irongate.swansea.linux.org.uk>
References: <200207122039.g6CKdnV3004060@napali.hpl.hp.com> 
	<1026512102.9915.22.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 12 Jul 2002 14:13:05 -0700
Message-Id: <1026508385.1352.401.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-07-12 at 15:15, Alan Cox wrote:

> In no overcommit mode MAP_NORESERVE is never honoured. In conventional
> overcommit mode I may have broken something between base and -ac. Which
> bit of the code are you looking at ?

As far as I can tell, the code is correct as you say and MAP_NORESERVE
is only not honored in the strict overcommit modes...

	Robert Love

