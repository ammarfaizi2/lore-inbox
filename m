Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423309AbWF1MLr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423309AbWF1MLr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 08:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423311AbWF1MLr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 08:11:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15824 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423309AbWF1MLq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 08:11:46 -0400
Date: Wed, 28 Jun 2006 05:11:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: mingo@elte.hu, arjan@infradead.org, schwidefsky@de.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] lockdep: special s390 print_symbol() version
Message-Id: <20060628051124.22607c8f.akpm@osdl.org>
In-Reply-To: <20060628120635.GE9452@osiris.boeblingen.de.ibm.com>
References: <20060628112435.GD9452@osiris.boeblingen.de.ibm.com>
	<20060628120635.GE9452@osiris.boeblingen.de.ibm.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jun 2006 14:06:35 +0200
Heiko Carstens <heiko.carstens@de.ibm.com> wrote:

> Martin made me just aware of __builtin_extract_return_addr() which will
> do the trick as well and avoids adding yet another ifdef.

Does gcc-3.2 support that?
