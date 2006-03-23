Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422674AbWCWUWZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422674AbWCWUWZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 15:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422675AbWCWUWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 15:22:25 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:60575 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1422674AbWCWUWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 15:22:25 -0500
Subject: Re: [RFC][PATCH 1/10] 64 bit resources core changes
From: Arjan van de Ven <arjan@infradead.org>
To: vgoyal@in.ibm.com
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Morton Andrew Morton <akpm@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, galak@kernel.crashing.org,
       gregkh@suse.de, bcrl@kvack.org, Dave Jiang <dave.jiang@gmail.com>,
       Maneesh Soni <maneesh@in.ibm.com>, Murali <muralim@in.ibm.com>
In-Reply-To: <20060323195944.GE7175@in.ibm.com>
References: <20060323195752.GD7175@in.ibm.com>
	 <20060323195944.GE7175@in.ibm.com>
Content-Type: text/plain
Date: Thu, 23 Mar 2006 21:22:15 +0100
Message-Id: <1143145335.3147.52.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-23 at 14:59 -0500, Vivek Goyal wrote:


> +			width, (unsigned long long) r->start,
> +			width, (unsigned long long) r->end,


hmmmm are there any platforms where unsigned long long is > 64 bits?
(and yes it would be nice if there was a u64 printf flag ;)



