Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932123AbWCWOGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbWCWOGu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 09:06:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932151AbWCWOGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 09:06:50 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:28638 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932123AbWCWOGu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 09:06:50 -0500
Subject: Re: Triggering Machine Check Exceptions on x86
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kalyan Rajasekharuni <kalyan@vmware.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4421F89A.2070406@vmware.com>
References: <4421F89A.2070406@vmware.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 23 Mar 2006 14:13:53 +0000
Message-Id: <1143123234.11163.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2006-03-22 at 17:23 -0800, Kalyan Rajasekharuni wrote:
> I would like to trigger a Machine Check Exception soley by a 
> 'software mechanism' on my x86 box. The idea is to test my 
> machine check exception handler thoroughly. I want a reliable 
> way which will generate this exception every time when I run 
> the software code snippet. 

You will need to ask the CPU vendor I think. You can trigger MCEs on
some x86s by exploiting obscure hardware flaws in supervisor mode
(notably with mismatched memory cache types for the same page) but I
don't know of any way to make that predictable.

Alan

