Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264648AbUEVCfj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264648AbUEVCfj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 22:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264719AbUEVCcv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 22:32:51 -0400
Received: from fw.osdl.org ([65.172.181.6]:51367 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264648AbUEUWiH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 18:38:07 -0400
Date: Thu, 20 May 2004 23:40:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6-mm] Make i386 boot not so chatty
Message-Id: <20040520234006.291c3dfa.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0405210032160.2864@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0405210032160.2864@montezuma.fsmlabs.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@arm.linux.org.uk> wrote:
>
> This patch silences the default i386 boot by putting a lot of development
>  related printks under KERN_DEBUG loglevel, allowing the normal chatty mode
>  to be turned on by using the 'debug' kernel parameter.

I think I like it chatty.  Turning this stuff off by default makes kernel
developers' lives that little bit harder.

Is the `quiet' option not suitable?
