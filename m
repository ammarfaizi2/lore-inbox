Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbTJVVxJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 17:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbTJVVxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 17:53:09 -0400
Received: from fw.osdl.org ([65.172.181.6]:41707 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261234AbTJVVxI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 17:53:08 -0400
Subject: Re: 2.6.0-test8: 'sleeping function called from invalid context at
	include/asm/semaphore.h: 119' at boot
From: Mark Haverkamp <markh@osdl.org>
To: bd <bdonlan@users.sourceforge.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <rcug61-a26.ln1@bd-home-comp.no-ip.org>
References: <rcug61-a26.ln1@bd-home-comp.no-ip.org>
Content-Type: text/plain
Message-Id: <1066859275.1499.25.camel@markh1.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 22 Oct 2003 14:47:56 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-10-21 at 17:08, bd wrote:


...

> 
> The system runs fine once it finishes booting, however, except that
> 'xosview' hangs at startup and must be killed.

I believe that this is because the format of /proc/stat has changed.

-- 
Mark Haverkamp <markh@osdl.org>

