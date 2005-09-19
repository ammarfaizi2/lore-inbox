Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932357AbVISI5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932357AbVISI5m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 04:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932386AbVISI5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 04:57:42 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:58352 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S932357AbVISI5l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 04:57:41 -0400
Subject: Re: [PATCH] more sigkill priority fix
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Roland McGrath <roland@redhat.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>,
       Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-kernel@vger.kernel.org,
       ralf@linux-mips.org, macro@linux-mips.org, akpm@osdl.org, dev@sw.ru
In-Reply-To: <20050919084607.0D50C180E1D@magilla.sf.frob.com>
References: <20050919084607.0D50C180E1D@magilla.sf.frob.com>
Content-Type: text/plain
Date: Mon, 19 Sep 2005 10:57:44 +0200
Message-Id: <1127120264.4897.34.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-09-19 at 01:46 -0700, Roland McGrath wrote:
> > Is this the way the kernel is supposed to handle signals now?
> > Just wondering, since this changes signal handling quite significantly from
> > what it was before.
> 
> It has always been the correct behavior.

Does that mean that it is incorrect to deliver one signal at a time?

-- 
blue skies,
   Martin

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH


