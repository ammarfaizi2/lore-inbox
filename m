Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270506AbRHHPRD>; Wed, 8 Aug 2001 11:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270507AbRHHPQx>; Wed, 8 Aug 2001 11:16:53 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:57732
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S270506AbRHHPQd>; Wed, 8 Aug 2001 11:16:33 -0400
Date: Wed, 8 Aug 2001 08:16:38 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: ext3-users@redhat.com
Cc: linux-kernel@vger.kernel.org, Carsten Otte <COTTE@de.ibm.com>
Subject: Re: BUG: Assertion failure with ext3-0.95 for 2.4.7
Message-ID: <20010808081638.K2399@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <OF5E574EE5.AF3B6F6F-ONC1256AA2.0026D8D3@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF5E574EE5.AF3B6F6F-ONC1256AA2.0026D8D3@de.ibm.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2001 at 10:46:41AM +0200, Christian Borntraeger wrote:

> I tested ext3 on a Linux for S/390 with several stress and benchmark test
> tests and faced a kernel bug message.
> The console showed the following output:
> 
> Message from syslogd@boeaet34 at Fri Aug  3 11:34:16 2001 ...
> boeaet34 kernel: Assertion failure in journal_forget() at
> transaction.c:1184: "!
> jh->b_committed_data"

Hmm.  I managed to get that oops on my PPC box too.  Can you turn on the
buffer trace code, reproduce it and post the log of that?  I bet it looks
a lot like the one I got...

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
