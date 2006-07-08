Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964887AbWGHQNp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964887AbWGHQNp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 12:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964886AbWGHQNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 12:13:45 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:21423 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964887AbWGHQNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 12:13:44 -0400
Subject: Re: [PATCH] Make cpu_relax() imply barrier() on all arches
From: Arjan van de Ven <arjan@infradead.org>
To: Chase Venters <chase.venters@clientec.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200607081110.52319.chase.venters@clientec.com>
References: <200607081110.52319.chase.venters@clientec.com>
Content-Type: text/plain
Date: Sat, 08 Jul 2006 18:13:41 +0200
Message-Id: <1152375221.3120.62.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-08 at 11:10 -0500, Chase Venters wrote:
> 
>  include/asm-frv/processor.h       |    3 ++-
>  include/asm-h8300/processor.h     |    3 ++-
>  include/asm-m68knommu/processor.h |    3 ++-
>  include/asm-sh/processor.h        |    3 ++-
>  include/asm-sh64/processor.h      |    3 ++-
>  include/asm-v850/processor.h      |    3 ++-
>  include/asm-xtensa/processor.h    |    3 ++-

cpu_relax() indeed is supposed have barrier() semantics!


Acked-by: Arjan van de Ven <arjan@Linux.intel.com>

