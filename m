Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263858AbTDVUko (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 16:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263859AbTDVUko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 16:40:44 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:10245 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263858AbTDVUkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 16:40:42 -0400
Date: Tue, 22 Apr 2003 21:52:47 +0100
From: Christoph Hellwig <hch@infradead.org>
To: David Ford <david+cert@blue-labs.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: devfs_register(cpu/microcode): illegal mode: 8180
Message-ID: <20030422215247.A12367@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Ford <david+cert@blue-labs.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
References: <3EA56D99.8060300@blue-labs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3EA56D99.8060300@blue-labs.org>; from david+cert@blue-labs.org on Tue, Apr 22, 2003 at 12:28:09PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 22, 2003 at 12:28:09PM -0400, David Ford wrote:
> FYI, Still hasn't been fixed in 2.5.68 :)

There's no call to devfs_register in arch/i386/kernel/microcode.c
in 2.5.68 anymore.

