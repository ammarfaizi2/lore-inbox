Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755865AbWKWEMm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755865AbWKWEMm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 23:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755867AbWKWEMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 23:12:41 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:41088
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1755865AbWKWEMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 23:12:41 -0500
Date: Wed, 22 Nov 2006 20:12:44 -0800 (PST)
Message-Id: <20061122.201244.31641809.davem@davemloft.net>
To: akpm@osdl.org
Cc: dada1@cosmosbay.com, viro@ftp.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dont insert pipe dentries into dentry_hashtable.
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061122133618.da95e48e.akpm@osdl.org>
References: <200611221602.29597.dada1@cosmosbay.com>
	<200611221848.41330.dada1@cosmosbay.com>
	<20061122133618.da95e48e.akpm@osdl.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
Date: Wed, 22 Nov 2006 13:36:18 -0800

> The DCACHE_UNHASHED games seem hacky.

Note this DCACHE_UNHASHES scheme was Al Viro's suggested
implementation :-)
