Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261154AbVEFG0f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbVEFG0f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 02:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261155AbVEFG0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 02:26:34 -0400
Received: from ozlabs.org ([203.10.76.45]:989 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261154AbVEFG0d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 02:26:33 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17019.3651.107704.631078@cargo.ozlabs.ibm.com>
Date: Fri, 6 May 2005 16:27:15 +1000
From: Paul Mackerras <paulus@samba.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: akpm@osdl.org, johnrose@austin.ibm.com, linux-kernel@vger.kernel.org,
       anton@samba.org
Subject: Re: [PATCH] enable CONFIG_RTAS_PROC by default
In-Reply-To: <1115343066.6503.6.camel@localhost.localdomain>
References: <17018.51064.311305.718975@cargo.ozlabs.ibm.com>
	<1115343066.6503.6.camel@localhost.localdomain>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven writes:

> shouldn't this move over to sysfs at some point, to some firmware
> directory ?

Well, eventually maybe, but there are userspace programs using it, so
we can't remove the /proc interface for a while yet.

Paul.
