Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263803AbTKKWbv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 17:31:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263806AbTKKWbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 17:31:51 -0500
Received: from janus.zeusinc.com ([205.242.242.161]:45683 "EHLO
	zso-proxy.zeusinc.com") by vger.kernel.org with ESMTP
	id S263803AbTKKWbO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 17:31:14 -0500
Subject: Re: Nick's scheduler v18
From: Tom Sightler <ttsig@tuxyturvy.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: piggin@cyberone.com.au
In-Reply-To: <1068589319.1557.1.camel@localhost.localdomain>
References: <1068589319.1557.1.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1068589837.1557.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 11 Nov 2003 17:30:38 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-11-11 at 17:22, Tom Sightler wrote:
> http://www.kerneltrap.org/~npiggin/v18/
> 
> Nothing exciting for desktop users. High end performance is now starting
> to get better.

Hey Nick,

Was this tested against single processor?  On my Dell Latitude C810 I
can boot test9 and test9-mm2 without problems, but using the identical
config with this patch my system will not even boot up all the way.  It
stops at various stages during the init scripts.  It seems to
consistently get further if I add elevator=deadline but it never boots
all the way up in either case.

No messages or other good info, just hangs and won't go any further. 
Any thoughts?

Later,
Tom


