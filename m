Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315260AbSHAO4X>; Thu, 1 Aug 2002 10:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315370AbSHAO4X>; Thu, 1 Aug 2002 10:56:23 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:51951 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315260AbSHAO4X>; Thu, 1 Aug 2002 10:56:23 -0400
Subject: Re: [bug, 2.5.29, IDE] partition table corruption?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: martin@dalecki.de
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <3D493C3B.2060609@evision.ag>
References: <Pine.LNX.4.44.0208011541590.19906-100000@localhost.localdomain> 
	<3D493C3B.2060609@evision.ag>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 01 Aug 2002 17:16:44 +0100
Message-Id: <1028218604.15022.59.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-01 at 14:48, Marcin Dalecki wrote:
> And what leads you to the assumption that it is actually the
> IDE code, which is to be blamed for this?

Side question Martin - is the IDE flush cache on close stuff in the 2.5
tree yet. That might be a candidate for this
