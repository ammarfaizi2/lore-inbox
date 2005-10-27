Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964976AbVJ0HG0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964976AbVJ0HG0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 03:06:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964975AbVJ0HG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 03:06:26 -0400
Received: from ms005msg.fastwebnet.it ([213.140.2.50]:34028 "EHLO
	ms005msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S964976AbVJ0HGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 03:06:25 -0400
Date: Thu, 27 Oct 2005 09:06:31 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: Chaitanya Hazarey <c.v.hazarey@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel MD5 sums and some question
Message-ID: <20051027090631.3217fb2e@localhost>
In-Reply-To: <9a9abfb40510262356o5de2a638pa15d0c8e9dda2833@mail.gmail.com>
References: <9a9abfb40510262356o5de2a638pa15d0c8e9dda2833@mail.gmail.com>
X-Mailer: Sylpheed-Claws 1.9.13 (GTK+ 2.6.8; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Oct 2005 12:26:16 +0530
Chaitanya Hazarey <c.v.hazarey@gmail.com> wrote:

> The next question I would like to ask is that, how to I go
> incrementally from linux kernel version 2.6.12.6 to 2.6.13 as no
> patches seem to be provided for it.

patch-2.6.13 applies to 2.6.12, so you should revert 2.6.12.6 (patch
-R) and then apply patch-2.6.13.

This is a tool to automate the process:

	http://www.selenic.com/ketchup/wiki/

-- 
	Paolo Ornati
	Linux 2.6.14-rc5-gd475f3f4 on x86_64
