Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268663AbUIAGBS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268663AbUIAGBS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 02:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268675AbUIAGBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 02:01:18 -0400
Received: from mailhub.hp.com ([192.151.27.10]:44676 "EHLO mailhub.hp.com")
	by vger.kernel.org with ESMTP id S268663AbUIAGBG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 02:01:06 -0400
Subject: Re: How to run 2.6.8.1 on Tiger 4
From: Alex Williamson <alex.williamson@hp.com>
To: chiwq@yahoo.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040901020454.68801.qmail@web52502.mail.yahoo.com>
References: <20040901020454.68801.qmail@web52502.mail.yahoo.com>
Content-Type: text/plain
Date: Wed, 01 Sep 2004 00:00:56 -0600
Message-Id: <1094018457.11226.18.camel@mythbox>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.92.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-31 at 19:04 -0700, wrote:
> I can run 2.6.0 with ia64 ports on Tiger 4,
> bun can not run 2.6.4 with ia64 ports on it ,
> and can not run 2.6.8.1 on Tiger 4.
> 
> How to do?
> 

Stock 2.6.8.1 should work just fine.

# cp arch/ia64/configs/generic_defconfig .config
# make oldconfig
# make compressed

If that's not bootable post specific detail about how it fails
(preferably console log) to the linux-ia64 list.  Thanks,

	Alex

