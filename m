Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270272AbTGWNIK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 09:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270280AbTGWNIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 09:08:10 -0400
Received: from rth.ninka.net ([216.101.162.244]:41856 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S270272AbTGWNIH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 09:08:07 -0400
Date: Wed, 23 Jul 2003 06:23:10 -0700
From: "David S. Miller" <davem@redhat.com>
To: Bgs himself <bgs@callnet.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6-test1 : make *config doesn't work
Message-Id: <20030723062310.33fc30a5.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.21.0307231237220.10880-100000@bgs.callnet.ln>
References: <Pine.LNX.4.21.0307231237220.10880-100000@bgs.callnet.ln>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jul 2003 12:44:07 +0200 (MEST)
Bgs himself <bgs@callnet.hu> wrote:

> [1.] make *config doens't compile
 ...
> scripts/modpost.c: In function `handle_modversions':
> scripts/modpost.c:302: `STT_REGISTER' undeclared (first use in this
> function)
 ...
> [7.] Slackware distro

Your glibc has a /usr/include/elf.h which is out of date.
