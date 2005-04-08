Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262647AbVDHAya@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262647AbVDHAya (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 20:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262638AbVDHAwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 20:52:15 -0400
Received: from fire.osdl.org ([65.172.181.4]:65489 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262640AbVDHAuu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 20:50:50 -0400
Date: Thu, 7 Apr 2005 17:50:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Wilson <njw@osdl.org>
Cc: linux-kernel@vger.kernel.org, rddunlap@osdl.org
Subject: Re: [PATCH 0/6] add generic round_up_pow2() macro
Message-Id: <20050407175042.43c02ae9.akpm@osdl.org>
In-Reply-To: <20050408004428.GA4260@njw.pdx.osdl.net>
References: <20050408004428.GA4260@njw.pdx.osdl.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Wilson <njw@osdl.org> wrote:
>
> The first patch adds a generic round_up_pow2() macro to kernel.h. The
>  remaining patches modify a few files to make use of the new macro.

We already have ALIGN() and roundup_pow_of_two().
