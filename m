Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270187AbTGMJK7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 05:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270188AbTGMJK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 05:10:59 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:51213 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S270187AbTGMJK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 05:10:58 -0400
Date: Sun, 13 Jul 2003 10:25:43 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5 and devfs versioning
Message-ID: <20030713102543.B24901@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrey Borzenkov <arvidjaar@mail.ru>, linux-kernel@vger.kernel.org
References: <200307131132.46522.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200307131132.46522.arvidjaar@mail.ru>; from arvidjaar@mail.ru on Sun, Jul 13, 2003 at 11:32:46AM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 13, 2003 at 11:32:46AM +0400, Andrey Borzenkov wrote:
> {pts/2}% dmesg | head -1
> Linux version 2.5.75-1borsmp ...
> 
> {pts/2}% dmesg | grep devfs
> Kernel command line: BOOT_IMAGE=2575-1borsmp ro root=345 devfs=mount
> devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
> 
> well, this is not quite correct to put it mildly. It has been so much changed 
> that IMHO it needs own version just to avoid confusion.

Just rip out the whole printk then.  Componentes that are maintained inside
the kernel tree don't need version numbers.

