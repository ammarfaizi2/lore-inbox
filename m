Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265237AbUFHQjz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265237AbUFHQjz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 12:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265249AbUFHQjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 12:39:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:39864 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265237AbUFHQjy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 12:39:54 -0400
Date: Tue, 8 Jun 2004 09:39:49 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
       David Howells <dhowells@redhat.com>
Subject: Re: downgrade_write replacement in remap_file_pages
In-Reply-To: <20040608093111.01a910e9.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0406080937150.31900@evo.osdl.org>
References: <20040608154438.GK18083@dualathlon.random> <20040608093111.01a910e9.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 8 Jun 2004, Andrew Morton wrote:
> 
> So ho-hum.  As a first step, David, could you please take a look into
> what's up with downgrade_write()?

One reason why I like Andrea's approach (regardless of downgrade_write()) 
is that it seems to avoid taking the heavy lock (write) by default. 

		Linus
