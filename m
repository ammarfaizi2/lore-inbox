Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262272AbTJFOqQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 10:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262274AbTJFOqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 10:46:16 -0400
Received: from pub237.cambridge.redhat.com ([213.86.99.237]:21245 "EHLO
	executor.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id S262272AbTJFOqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 10:46:12 -0400
Subject: Re: [PATCH] Memory leak in mtd/chips/cfi_cmdset_0020
From: David Woodhouse <dwmw2@redhat.com>
To: Felipe W Damasio <felipewd@terra.com.br>
Cc: linux-mtd@lists.infradead.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3F81800A.5000500@terra.com.br>
References: <3F81800A.5000500@terra.com.br>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Red Hat UK Ltd.
Message-Id: <1065451568.22491.215.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-2.dwmw2.3) 
Date: Mon, 06 Oct 2003 15:46:09 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-10-06 at 11:45 -0300, Felipe W Damasio wrote:
> 	Hi David,
> 
> 	Patch against 2.6.0-test6.
> 
> 	- Frees a previous allocated kmalloced variable before returning NULL;
> 
> 	Found by smatch.

Applied; thanks. It'll be in the next update sent to Linus, when I get a
few spare moments for merging and testing.

Out of interest, why didn't smatch also find the same error 25 lines
further down?

-- 
dwmw2
