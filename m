Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310611AbSCMOby>; Wed, 13 Mar 2002 09:31:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310617AbSCMObp>; Wed, 13 Mar 2002 09:31:45 -0500
Received: from ns.suse.de ([213.95.15.193]:44810 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S310613AbSCMOba>;
	Wed, 13 Mar 2002 09:31:30 -0500
Date: Wed, 13 Mar 2002 15:31:27 +0100
From: Dave Jones <davej@suse.de>
To: Russell King <rmk@arm.linux.org.uk>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.6 scsi DMA mapping and compilation fixes (not yet working)
Message-ID: <20020313153127.H7658@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Russell King <rmk@arm.linux.org.uk>,
	"Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200203122355.PAA08344@adam.yggdrasil.com> <20020313000229.D13558@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020313000229.D13558@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Wed, Mar 13, 2002 at 12:02:29AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2002 at 12:02:29AM +0000, Russell King wrote:
 > 
 > Someone had a go at "making 2.5 compile" without taking Alan's 2.4
 > changes. It went into Linus tree.  It got subsequently reverted
 > because of the reasons I outlined in my previous mail.

I pushed that revert to Linus. It was basically a cp of the driver
from the 2.4 tree to the current 2.5 one, diff and send. 
At least if someone now tries to "fix" it, it won't be lacking
any of the locking fixes that Alan did for 2.4.17

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
