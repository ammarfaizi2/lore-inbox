Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262577AbVBXXkO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262577AbVBXXkO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 18:40:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262559AbVBXXfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 18:35:44 -0500
Received: from fire.osdl.org ([65.172.181.4]:36774 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262564AbVBXXdN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 18:33:13 -0500
Date: Thu, 24 Feb 2005 15:32:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: Chris Friesen <cfriesen@nortel.com>
Cc: chad@tindel.net, helge.hafting@aitel.hist.no, linux-kernel@vger.kernel.org
Subject: Re: Xterm Hangs - Possible scheduler defect?
Message-Id: <20050224153249.1bf4db1e.akpm@osdl.org>
In-Reply-To: <421E61CC.5090302@nortel.com>
References: <20050223230639.GA33795@calma.pair.com>
	<20050223183634.31869fa6.akpm@osdl.org>
	<20050224052630.GA99960@calma.pair.com>
	<421DD5CC.5060106@aitel.hist.no>
	<20050224173356.GA11593@calma.pair.com>
	<20050224150026.69b1862f.akpm@osdl.org>
	<421E61CC.5090302@nortel.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen <cfriesen@nortel.com> wrote:
>
> Andrew Morton wrote:
> 
>  > 	chrt -r 99 -9 $i

Make that

	chrt -r 99 -p $i
