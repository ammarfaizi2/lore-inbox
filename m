Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263539AbTJOQZK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 12:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263540AbTJOQZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 12:25:10 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:22710 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263539AbTJOQZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 12:25:07 -0400
Subject: Re: Transparent compression in the FS
From: David Woodhouse <dwmw2@infradead.org>
To: josh@temp123.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1066163449.4286.4.camel@Borogove>
References: <1066163449.4286.4.camel@Borogove>
Content-Type: text/plain
Message-Id: <1066235105.14783.1602.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-2.dwmw2.3) 
Date: Wed, 15 Oct 2003 17:25:06 +0100
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: dwmw2@infradead.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
X-Pentafluge-Mail-From: <dwmw2@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-10-14 at 16:30 -0400, Josh Litherland wrote:
> Are there any filesystems which implement the transparent compression
> attribute ?  (chattr +c)

JFFS2 doesn't implement 'chattr +c', which is in fact an EXT2-private
ioctl. But it does do transparent compression.

-- 
dwmw2

