Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270511AbRHHP2O>; Wed, 8 Aug 2001 11:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270512AbRHHP2E>; Wed, 8 Aug 2001 11:28:04 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:59780
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S270511AbRHHP1w>; Wed, 8 Aug 2001 11:27:52 -0400
Date: Wed, 8 Aug 2001 08:27:55 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Christian Borntraeger <CBORNTRA@de.ibm.com>
Cc: Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: BUG: Assertion failure with ext3-0.95 for 2.4.7
Message-ID: <20010808082755.M2399@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <OF1F8FDF9C.400E6F0B-ONC1256AA2.004F74C5@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF1F8FDF9C.400E6F0B-ONC1256AA2.004F74C5@de.ibm.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2001 at 04:38:36PM +0200, Christian Borntraeger wrote:

> I also tested it with a 70GB LVM and /proc/sys/fs/jbd-debug set to 5.There
> was also no error. After reset to 0 the error reoccured (???)
> Next, I will try,using md instead of LVM to have a disk with a similar
> size.

Sounds like my crash on PPC again :)  W/ jbd-debug set to 5 there's so much
I/O going on (writing out the logs) that the bug doesn't happen, I suspect.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
