Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751016AbWGCSid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbWGCSid (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 14:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751008AbWGCSid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 14:38:33 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:5058 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750728AbWGCSic
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 14:38:32 -0400
Date: Mon, 3 Jul 2006 19:38:32 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Joshua Hudson <joshudson@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 20/20] honor r/w changes at do_remount() time
Message-ID: <20060703183832.GE29920@ftp.linux.org.uk>
References: <20060627221436.77CCB048@localhost.localdomain> <20060627221457.04ADBF71@localhost.localdomain> <20060628051935.GA29920@ftp.linux.org.uk> <1151947814.11159.147.camel@localhost.localdomain> <20060703174804.GD29920@ftp.linux.org.uk> <bda6d13a0607031123p78a60f90u385be194e1623856@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bda6d13a0607031123p78a60f90u385be194e1623856@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2006 at 11:23:06AM -0700, Joshua Hudson wrote:
> That would be a poor assumption. Somebody could do ln /proc/pid/fd/3
> /mnt/newname at this point.

Why don't you try it?
