Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274978AbTHFXyM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 19:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269523AbTHFXyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 19:54:12 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:1298 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S274978AbTHFXwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 19:52:07 -0400
Date: Thu, 7 Aug 2003 00:52:03 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: [Linux-fbdev-devel] [PATCH] Framebuffer: 2nd try: client
 notification mecanism & PM
In-Reply-To: <1059732286.8184.43.camel@gaston>
Message-ID: <Pine.LNX.4.44.0308070000540.17315-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> James, if you are ok, can you get that upstream to Linus asap so
> I can start pushing the driver bits for radeon & aty128 ?

Working on it. I'm thinking about also how it effects userland and how 
userland affects the console if present. Basically the logic will go 

pci suspend ->  framebuffer driver supend function -> call each client

Just give me a few days to piece it together.



