Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264134AbUDGHyH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 03:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264135AbUDGHyG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 03:54:06 -0400
Received: from fw.osdl.org ([65.172.181.6]:54236 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264134AbUDGHyF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 03:54:05 -0400
Date: Wed, 7 Apr 2004 00:53:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linux-kernel@vger.kernel.org, benh@kernel.crashing.org, anton@samba.org,
       paulus@samba.org, linuxppc64-dev@lists.linuxppc.org
Subject: Re: RFC: COW for hugepages
Message-Id: <20040407005353.45323dcd.akpm@osdl.org>
In-Reply-To: <20040407074239.GG18264@zax>
References: <20040407074239.GG18264@zax>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gibson <david@gibson.dropbear.id.au> wrote:
>
> Doing the COW for hugepages turns out not to be terribly difficult.
>  Is there any reason not to apply this patch?

Not much, except that it adds stuff to the kernel.

Does anyone actually have a real-world need for the feature?
