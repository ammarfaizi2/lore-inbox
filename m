Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262106AbVBXIzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbVBXIzK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 03:55:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262097AbVBXIzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 03:55:10 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:65302 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S262106AbVBXIzF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 03:55:05 -0500
Message-ID: <421D9661.1080208@zensonic.dk>
Date: Thu, 24 Feb 2005 09:54:57 +0100
From: "Thomas S. Iversen" <zensonic@zensonic.dk>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Help tracking down problem --- endless loop in __find_get_block_slow
References: <4219BC1A.1060007@zensonic.dk>	<20050222011821.2a917859.akpm@osdl.org>	<20050223120013.GA28169@zensonic.dk>	<20050223041036.5f5df2ff.akpm@osdl.org>	<20050223130251.GA31851@zensonic.dk>	<20050223120928.133778a4.akpm@osdl.org>	<421D029E.8010600@zensonic.dk> <20050223151756.22c8c48d.akpm@osdl.org>
In-Reply-To: <20050223151756.22c8c48d.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't know.   Can you describe how your driver implements the remapping?

I have tested with ext2. I get double faults when trying to sync.
What are those? (By the look of the error message, I can see they are 
not something I want to have :-)

I'm at loss how all of this can happend. All I do is to allocate BIOs 
and kernel memory, process the BIOs and deal with deallocation afterwards.

Thomas


