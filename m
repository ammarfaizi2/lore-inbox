Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261311AbUKKFvx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbUKKFvx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 00:51:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262093AbUKKFvx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 00:51:53 -0500
Received: from fw.osdl.org ([65.172.181.6]:14053 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261311AbUKKFvw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 00:51:52 -0500
Date: Wed, 10 Nov 2004 21:51:42 -0800
From: Andrew Morton <akpm@osdl.org>
To: Tim Hockin <thockin@google.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: small PCI probe patch for odd 64 bit BARs
Message-Id: <20041110215142.3a81b426.akpm@osdl.org>
In-Reply-To: <20041111044809.GE19615@google.com>
References: <20041111044809.GE19615@google.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Hockin <thockin@google.com> wrote:
>
> +			sz = pci_size(sz, 0xffffffff);

pci_size() takes three arguments, so this patch appears to not have been
runtime tested :( 
