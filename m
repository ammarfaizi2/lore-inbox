Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317142AbSFQXXz>; Mon, 17 Jun 2002 19:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317148AbSFQXXy>; Mon, 17 Jun 2002 19:23:54 -0400
Received: from ns.suse.de ([213.95.15.193]:11531 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317142AbSFQXXy>;
	Mon, 17 Jun 2002 19:23:54 -0400
Date: Tue, 18 Jun 2002 01:23:55 +0200
From: Dave Jones <davej@suse.de>
To: Dale Amon <amon@vnl.com>, linux-kernel@vger.kernel.org
Subject: Re: Eisa option problem in 2.5.22
Message-ID: <20020618012355.K758@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Dale Amon <amon@vnl.com>, linux-kernel@vger.kernel.org
References: <20020617230002.GC24436@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020617230002.GC24436@vnl.com>; from amon@vnl.com on Tue, Jun 18, 2002 at 12:00:02AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2002 at 12:00:02AM +0100, Dale Amon wrote:
 > A minor build problem. I turned the EISA bus option off and then it
 > successfully compiled.
 > 
 > make[1]: *** No rule to make target `eisa.o', needed by `kernel.o'.  Stop.
 > make: *** [arch/i386/kernel] Error 2

Just delete eisa.o from arch/i386/kernel/Makefile
It's a bogon that slipped in from my tree.

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
