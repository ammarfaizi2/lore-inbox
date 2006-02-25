Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932689AbWBYM2p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932689AbWBYM2p (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 07:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932690AbWBYM2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 07:28:44 -0500
Received: from smtp.osdl.org ([65.172.181.4]:51618 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932689AbWBYM2n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 07:28:43 -0500
Date: Sat, 25 Feb 2006 04:27:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/23] proc cleanup.
Message-Id: <20060225042757.1442ee2c.akpm@osdl.org>
In-Reply-To: <m1oe0yhy1w.fsf@ebiederm.dsl.xmission.com>
References: <m1oe0yhy1w.fsf@ebiederm.dsl.xmission.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) wrote:
>
> When working on pid namespaces I keep tripping over /proc.
>  It's hard coded inode numbers and the amount of cruft
>  accumulated over the years makes it hard to deal with.
> 
>  So to put /proc out of my misery here is a series of patches that
>  removes the worst of the warts.

An additional 2.7k of vmlinux.  A shame.
