Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261820AbTDQRnR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 13:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbTDQRnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 13:43:17 -0400
Received: from air-2.osdl.org ([65.172.181.6]:7661 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261820AbTDQRnQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 13:43:16 -0400
Date: Thu, 17 Apr 2003 10:54:36 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Mads Christensen <mfc@krycek.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cannot boot 2.5.67
Message-Id: <20030417105436.3c70b895.rddunlap@osdl.org>
In-Reply-To: <1050601594.1073.1.camel@krycek>
References: <018401c30505$1a1e6200$6400a8c0@witbe>
	<1050601594.1073.1.camel@krycek>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There was also a thread about 1 week ago that indicated that
if CONFIG_LOG_BUF_SHIFT=<some very large number here>,
the kernel won't boot and won't tell you why.

E.g., if someone sets CONFIG_LOG_BUF_SHIFT to a buffer size in bytes
(or KB) instead of a shift value, it causes a very large log buffer
declaration and that's about all she wrote.

~Randy


On 17 Apr 2003 19:46:34 +0200 Mads Christensen <mfc@krycek.org> wrote:

| You have to get 
| CONFIG_INPUT=y, CONFIG_VT=y and CONFIG_VT_CONSOLE=y
| inorder for you to see anything =)
| 
| On tor, 2003-04-17 at 19:16, Paul Rolland wrote:
| > Got the same starting with 2.5.67...
| > I took the .config from the booting 2.5.66, made a 2.5.67 kernel,
| > and when booting, booh :-(
| > 
| > It was a RH8 base, Lilo... I'll try tonite to find out which option
| > is responsible of that...
| > 
| > Regards,
| > Paul
| > 
| > > I have a rh9 installation, grub is properly configured, and 
| > > when I select 
| > > to boot a 2.5 kernel it does not even decompress it. It stops 
| > > even before 
| > > printing the kernel version.
