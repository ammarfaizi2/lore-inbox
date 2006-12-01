Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967492AbWLAPbo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967492AbWLAPbo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 10:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967420AbWLAPbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 10:31:44 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:36587 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S967359AbWLAPbn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 10:31:43 -0500
Date: Fri, 1 Dec 2006 15:37:06 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Jan Glauber <jan.glauber@de.ibm.com>
Cc: linux-crypto <linux-crypto@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Pseudo-random number generator
Message-ID: <20061201153706.321926f5@localhost.localdomain>
In-Reply-To: <1164986446.5882.36.camel@bender>
References: <1164979155.5882.23.camel@bender>
	<20061201133924.023289c4@localhost.localdomain>
	<1164986446.5882.36.camel@bender>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Dec 2006 16:20:46 +0100
Jan Glauber <jan.glauber@de.ibm.com> wrote:
> Yes, a user can just symlink urandom to prandom and will have a faster
> generator.


More usefully they can use it as an entropy source with an entropy
daemon to feed it into the standard urandom/random.
