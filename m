Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264215AbTE0WQK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 18:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264272AbTE0WQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 18:16:10 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:34573 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264215AbTE0WQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 18:16:07 -0400
Date: Tue, 27 May 2003 23:29:19 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Paul Mackerras <paulus@samba.org>
cc: linux-kernel@vger.kernel.org, <linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] [PATCH] fix controlfb and platinumfb drivers
In-Reply-To: <16079.23061.979768.135318@argo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.44.0305272328300.26160-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This patch fixes the controlfb and platinumfb drivers so that the
> arguments to fb_set_var are in the correct order.  Please apply.

Applied. Tho it is strnage. You shouldn't need to call fb_set_var from the 
driver. 

