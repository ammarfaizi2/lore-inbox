Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423307AbWF1MRN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423307AbWF1MRN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 08:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423308AbWF1MRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 08:17:12 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:26325 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1423307AbWF1MRL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 08:17:11 -0400
Subject: Re: [patch] lockdep: special s390 print_symbol() version
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, mingo@elte.hu,
       arjan@infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060628051124.22607c8f.akpm@osdl.org>
References: <20060628112435.GD9452@osiris.boeblingen.de.ibm.com>
	 <20060628120635.GE9452@osiris.boeblingen.de.ibm.com>
	 <20060628051124.22607c8f.akpm@osdl.org>
Content-Type: text/plain
Organization: IBM Corporation
Date: Wed, 28 Jun 2006 14:17:20 +0200
Message-Id: <1151497040.5428.50.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-06-28 at 05:11 -0700, Andrew Morton wrote:
> On Wed, 28 Jun 2006 14:06:35 +0200
> Heiko Carstens <heiko.carstens@de.ibm.com> wrote:
> 
> > Martin made me just aware of __builtin_extract_return_addr() which will
> > do the trick as well and avoids adding yet another ifdef.
> 
> Does gcc-3.2 support that?

It was present in every version of gcc we used, even 2.95.3 had it.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


