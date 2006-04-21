Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750755AbWDUXZI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbWDUXZI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 19:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbWDUXZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 19:25:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2010 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750755AbWDUXZG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 19:25:06 -0400
Date: Fri, 21 Apr 2006 16:27:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Hua Zhong" <hzhong@gmail.com>
Cc: jmorris@namei.org, dwalker@mvista.com, linux-kernel@vger.kernel.org
Subject: Re: kfree(NULL)
Message-Id: <20060421162720.074bcfd4.akpm@osdl.org>
In-Reply-To: <000e01c66596$66961750$853d010a@nuitysystems.com>
References: <20060421144233.1201cf07.akpm@osdl.org>
	<000e01c66596$66961750$853d010a@nuitysystems.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


btw, I don't think a patch like this would be appropriate to mainline -
it's the sort of thing which just one or two people would use once or twice
per year.

So I'd be inclined to host it permanently in -mm, along with the other 37
mm-only debugging patches.

Consequently it doesn't have to be an especially gorgeous piece of code ;)

