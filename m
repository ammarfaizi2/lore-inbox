Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264836AbSLBSuU>; Mon, 2 Dec 2002 13:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264839AbSLBSuU>; Mon, 2 Dec 2002 13:50:20 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:48135
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S264836AbSLBSuT>; Mon, 2 Dec 2002 13:50:19 -0500
Subject: Re: [PATCH] set_cpus_allowed() for 2.4
From: Robert Love <rml@tech9.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Christoph Hellwig <hch@sgi.com>, marcelo@connectiva.com.br.munich.sgi.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <3DEB9761.50503@pobox.com>
References: <20021202192652.A25938@sgi.com>  <3DEB9761.50503@pobox.com>
Content-Type: text/plain
Organization: 
Message-Id: <1038855468.860.12.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 02 Dec 2002 13:57:48 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-12-02 at 12:24, Jeff Garzik wrote:

> Adding to that, it is also used for backporting Ingo's workqueue stuff, 
> which is useful and completely separate from the O(1) scheduler.

That is why I back-ported it - hch and you mentioned it was needed for
workqueues :)

It also simplifies the processor affinity syscalls (same code I did for
2.5, in fact), which I plan on submitting to Marcelo soon.

	Robert Love

