Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263332AbTDSAXU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 20:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263319AbTDSAXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 20:23:20 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:38094
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263332AbTDSAXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 20:23:19 -0400
Subject: Re: [TRIVIAL] kstrdup
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <b7pjcp$j8h$1@cesium.transmeta.com>
References: <Pine.LNX.4.44.0304180919380.2950-100000@home.transmeta.com>
	 <3EA02E55.80103@pobox.com> <Pine.LNX.4.53.0304181323400.22493@chaos>
	 <3EA0469D.7090602@pobox.com>  <b7pjcp$j8h$1@cesium.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050709030.2290.12.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 19 Apr 2003 00:37:11 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-04-18 at 20:24, H. Peter Anvin wrote:
> Followup to:  <3EA0469D.7090602@pobox.com>
> > 
> > Which is better?  I don't know; I'm still learning the performance 
> > eccentricities of x86 insns on various processors.
> > 
> 
> It varies from porocessor to processor, and also depends on usage.

Stepping to stepping, even clock speed at stepping in the case of some B
series pentiums. For large copies we hit the kernel optimised stuff like
MMX copiers, for small copies its irrelevant 

