Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262558AbVDABbc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262558AbVDABbc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 20:31:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262563AbVDABbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 20:31:32 -0500
Received: from fire.osdl.org ([65.172.181.4]:54966 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262558AbVDABb2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 20:31:28 -0500
Date: Thu, 31 Mar 2005 17:31:01 -0800
From: Andrew Morton <akpm@osdl.org>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: linux-kernel@vger.kernel.org
Subject: connector.h
Message-Id: <20050331173101.769f5c67.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> struct cb_id
> {
> 	__u32			idx;
> 	__u32			val;
> };

It is vital that all data structures be skilfully commented - they are the
key to understanding the code.  Why the struct exists, which actor passes
it to which other actor(s), whether the data structure is communicated with
userspace, what other data structures it is aggregated with or linked to,
locking rules, etc.

> struct cn_msg
> {

Please do

	struct cn_msg {

> 
> #define CN_CBQ_NAMELEN		32

Commentary?


