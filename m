Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbTJFTrx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 15:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbTJFTrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 15:47:53 -0400
Received: from adsl-216-102-214-42.dsl.snfc21.pacbell.net ([216.102.214.42]:62224
	"EHLO cynthia.pants.nu") by vger.kernel.org with ESMTP
	id S261239AbTJFTrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 15:47:51 -0400
Date: Mon, 6 Oct 2003 12:47:49 -0700
From: Brad Boyer <flar@allandria.com>
To: linux-hfsplus-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] new HFS(+) driver
Message-ID: <20031006194748.GB5202@pants.nu>
References: <Pine.LNX.4.44.0310021029110.17548-100000@serv> <20031002180645.GG7665@parcelfarce.linux.theplanet.co.uk> <20031002185248.GA24046@pants.nu> <20031006193841.GA1366@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031006193841.GA1366@matchmail.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 06, 2003 at 12:38:41PM -0700, Mike Fedyk wrote:
> Where can I find this hack?  I just had three CDs from cleints that have
> partition maps on them...
> 
> I've read them on our Mac (OS9.2), but I'd love to know how to read them
> under linux!

It's in the hfs and hfsplus modules as implemented in the patch mentioned
in the original message in this thread. The hfs code has had it for ages,
but this is the first version of the hfsplus code to support it. The
only issue is that you can only mount the one volume at a time, and it
has to be either HFS or HFS+. If you have a multi-volume CD, you can't
mount all of them. If you have a really stupid CD like the old A/UX
install CD with other filesystem types on it, you're out of luck
without copying it over to a hard drive and mounting with the loop
device and some careful trimming of the file.

	Brad Boyer
	flar@allandria.com

