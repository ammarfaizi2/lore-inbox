Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262263AbUCRAfj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 19:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262258AbUCRAfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 19:35:39 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:53635
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262253AbUCRAfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 19:35:33 -0500
Date: Thu, 18 Mar 2004 01:36:21 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: mlock sysctl name
Message-ID: <20040318003621.GC2113@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

can you tell me the name and the location of the mlock sysctl? For now
I'm going to allow remap_file_pages only if the mlock sysctl is enabled,
and at the same time I can allow all other mlocks too.

I was thinking at soemthing like "enable-local-mlock" but since you
already implemented it, it's worth to use the same one.

thanks.
