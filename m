Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261840AbTJRUn1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 16:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbTJRUn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 16:43:26 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56706 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261840AbTJRUn0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 16:43:26 -0400
Date: Sat, 18 Oct 2003 21:43:25 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Witold Krecicki <adasi@kernel.pl>
Cc: Svetoslav Slavtchev <svetljo@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: initrd and 2.6.0-test8
Message-ID: <20031018204325.GH7665@parcelfarce.linux.theplanet.co.uk>
References: <22900.1066504204@www30.gmx.net> <20031018192517.GD7665@parcelfarce.linux.theplanet.co.uk> <200310182232.55091.adasi@kernel.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310182232.55091.adasi@kernel.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 18, 2003 at 10:32:55PM +0200, Witold Krecicki wrote:

> What about situation when devfs is not mounted and even not used at all, and 
> it is still not working?

If it is configured, it gets mounted for a while by late-boot code.

Do you have CONFIG_DEVFS_FS=y in your .config?
