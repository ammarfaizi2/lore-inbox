Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030385AbVKHW5J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030385AbVKHW5J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 17:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965285AbVKHW5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 17:57:09 -0500
Received: from smtp.osdl.org ([65.172.181.4]:29074 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965211AbVKHW5I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 17:57:08 -0500
Date: Tue, 8 Nov 2005 14:56:56 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Jan Beulich" <JBeulich@novell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] minor ELF addition
Message-Id: <20051108145656.06e0d2b8.akpm@osdl.org>
In-Reply-To: <4370AE20.76F0.0078.0@novell.com>
References: <4370AE20.76F0.0078.0@novell.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jan Beulich" <JBeulich@novell.com> wrote:
>
> A trivial addition to the ELF definitions.
> 
> ...
>  #define STT_FILE    4
> +#define STT_COMMON  5
> +#define STT_TLS     6

Is there any particular reason for adding these, or is it just a
completeness thing?
