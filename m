Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262315AbVFUX74@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262315AbVFUX74 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 19:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262444AbVFUX41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 19:56:27 -0400
Received: from smtpauth05.mail.atl.earthlink.net ([209.86.89.65]:46007 "EHLO
	smtpauth05.mail.atl.earthlink.net") by vger.kernel.org with ESMTP
	id S262433AbVFUXvg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 19:51:36 -0400
In-Reply-To: <200506212324.19713.arnd@arndb.de>
References: <200506212310.54156.arnd@arndb.de> <200506212320.05799.arnd@arndb.de> <200506212322.36453.arnd@arndb.de> <200506212324.19713.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <eaabcca10740f5e2cd8a1ca86245ba5d@penguinppc.org>
Content-Transfer-Encoding: 7bit
Cc: ppc64-dev List <linuxppc64-dev@ozlabs.org>,
       Paul Mackerras <paulus@samba.org>,
       LKML list <linux-kernel@vger.kernel.org>
From: Hollis Blanchard <hollis@penguinppc.org>
Subject: Re: [PATCH 7/11] ppc64: add BPA platform type
Date: Tue, 21 Jun 2005 18:51:25 -0500
To: Arnd Bergmann <arnd@arndb.de>, ppc64-dev List <linuxppc64-dev@ozlabs.org>
X-Mailer: Apple Mail (2.622)
X-ELNK-Trace: 77a46389d001b1f223bcf3e39c2f8b5f1aa676d7e74259b7b3291a7d08dfec7924edcc7f8bd081fc8ed95f5c0bee22e1350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 63.246.184.80
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 21, 2005, at 4:24 PM, Arnd Bergmann wrote:

> +static void __init bpa_setup_arch(void)
> +{
> ...
> +	// bpa_nvram_init();
> +}

I didn't look closely, but I didn't see this called elsewhere... so 
probably shouldn't be commented out here?

-Hollis

