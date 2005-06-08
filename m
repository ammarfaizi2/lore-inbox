Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262000AbVFHVfn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262000AbVFHVfn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 17:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262002AbVFHVfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 17:35:43 -0400
Received: from fire.osdl.org ([65.172.181.4]:17352 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262000AbVFHVfd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 17:35:33 -0400
Date: Wed, 8 Jun 2005 14:35:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: dan.dickey@savvis.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: System state too high for too long...
Message-Id: <20050608143501.791edfd2.akpm@osdl.org>
In-Reply-To: <200506081158.40461.dan.dickey@savvis.net>
References: <200506071125.41543.dan.dickey@savvis.net>
	<20050607211310.7f6ee27e.akpm@osdl.org>
	<200506081158.40461.dan.dickey@savvis.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Dan A. Dickey" <dan.dickey@savvis.net> wrote:
>
>    8704 kernel_map_pages                          93.5914

Ah.  CONFIG_DEBUG_PAGEALLOC can be most expensive.  Please disable it and
try again.

