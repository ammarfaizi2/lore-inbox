Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264126AbUA0W1T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 17:27:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264366AbUA0W1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 17:27:19 -0500
Received: from ns.suse.de ([195.135.220.2]:31439 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264126AbUA0W1S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 17:27:18 -0500
Date: Tue, 27 Jan 2004 23:26:46 +0100
From: Andi Kleen <ak@suse.de>
To: Jan Kasprzak <kas@informatics.muni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SMP AMD64 (Tyan S2882) problems.
Message-Id: <20040127232646.1efda527.ak@suse.de>
In-Reply-To: <20040127224931.D24747@fi.muni.cz>
References: <20040127190911.B13769@fi.muni.cz.suse.lists.linux.kernel>
	<p73fze1fdk4.fsf@nielsen.suse.de>
	<20040127224931.D24747@fi.muni.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jan 2004 22:49:31 +0100
Jan Kasprzak <kas@informatics.muni.cz> wrote:


> 
> 	Does not work:
> 
> ioctl32(tw_cli:32216): Unknown cmd fd(3) cmd(0000001f){00} arg(080dd2e0) on /dev/twe0
> 
> I have asked 3ware.

You can probably fix that yourself by adding ioctl translation to the 3ware driver.
See http://www.firstfloor.org/~andi/writing-ioctl32 for details.

-Andi
