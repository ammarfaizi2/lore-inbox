Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965229AbWFIGeI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965229AbWFIGeI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 02:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965231AbWFIGeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 02:34:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:62623 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965229AbWFIGeF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 02:34:05 -0400
To: Sascha Nitsch <Sash_lkl@linuxhowtos.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Idea about a disc backed ram filesystem
References: <200606082233.13720.Sash_lkl@linuxhowtos.org>
From: Andi Kleen <ak@suse.de>
Date: 09 Jun 2006 08:33:56 +0200
In-Reply-To: <200606082233.13720.Sash_lkl@linuxhowtos.org>
Message-ID: <p73wtbqsuqz.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sascha Nitsch <Sash_lkl@linuxhowtos.org> writes:
> - all files overlayed are still accessible
> - after the first read, the file stays in memory (like a file cache)

Linux has very aggressive file caching and does this effectively
by default for every file system.

Sounds like you're trying to reinvent the wheel. 

-Andi
