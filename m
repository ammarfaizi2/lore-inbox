Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932404AbWAMHjo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932404AbWAMHjo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 02:39:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932526AbWAMHjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 02:39:44 -0500
Received: from smtp.osdl.org ([65.172.181.4]:186 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932404AbWAMHjo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 02:39:44 -0500
Date: Thu, 12 Jan 2006 23:39:20 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: [PATCH] reiserfs: remove kmalloc wrapper
Message-Id: <20060112233920.4b3b0a26.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0601130930130.17696@sbz-30.cs.Helsinki.FI>
References: <Pine.LNX.4.58.0601130930130.17696@sbz-30.cs.Helsinki.FI>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka J Enberg <penberg@cs.Helsinki.FI> wrote:
>
> This patch removes kmalloc() wrapper from fs/reiserfs/. Please note that 
>  a reiserfs /proc entry format is changed because kmalloc statistics is 
>  removed.

I wonder if it'd be safer to just spit out a zero where that number used to
be?

