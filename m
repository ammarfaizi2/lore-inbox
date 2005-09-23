Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751182AbVIWTpg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbVIWTpg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 15:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbVIWTpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 15:45:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61377 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751182AbVIWTpf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 15:45:35 -0400
Date: Fri, 23 Sep 2005 12:44:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: <Abhay_Salunke@Dell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: FW: [patch 2.6.14-rc2] dell_rbu: changes in packet update
 mechanism
Message-Id: <20050923124451.61694274.akpm@osdl.org>
In-Reply-To: <597A2BC19EDD3C458F841E8724E92D4B973E19@ausx3mps301.aus.amer.dell.com>
References: <597A2BC19EDD3C458F841E8724E92D4B973E19@ausx3mps301.aus.amer.dell.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<Abhay_Salunke@Dell.com> wrote:
>
> -static ssize_t write_rbu_image_type(struct kobject *kobj, char *buffer,
>  -			loff_t pos, size_t count)
>  +static ssize_t
>  +write_rbu_image_type(struct kobject *kobj, char *buffer, loff_t pos,

This is contrary to the conventional kernel coding style.  I suggest you
not include all these layout changes.

