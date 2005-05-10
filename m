Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261716AbVEJSGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261716AbVEJSGu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 14:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261721AbVEJSGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 14:06:50 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:23153
	"EHLO g5.random") by vger.kernel.org with ESMTP id S261716AbVEJSGt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 14:06:49 -0400
Date: Tue, 10 May 2005 20:06:42 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: blaisorblade@yahoo.it, jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [patch 1/6] uml: remove elf.h [ compile-fix, for 2.6.12 ]
Message-ID: <20050510180642.GY6313@g5.random>
References: <20050509224509.0C105416E4@zion> <20050509183401.28082cbc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050509183401.28082cbc.akpm@osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2005 at 06:34:01PM -0700, Andrew Morton wrote:
> I'll just ask Linus to delete it ;)

make distclean should delete it too. I never worry about zero length
file, they'll be deleted eventually.
