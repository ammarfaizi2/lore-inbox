Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271680AbRHQPnI>; Fri, 17 Aug 2001 11:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271677AbRHQPm6>; Fri, 17 Aug 2001 11:42:58 -0400
Received: from u-31-18.karlsruhe.ipdial.viaginterkom.de ([62.180.18.31]:63647
	"EHLO dea.waldorf-gmbh.de") by vger.kernel.org with ESMTP
	id <S271679AbRHQPmr>; Fri, 17 Aug 2001 11:42:47 -0400
Date: Fri, 17 Aug 2001 16:40:31 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: jes@trained-monkey.org
Cc: olivier.lebaillif@ifrsys.com, alan@redhat.com, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] dz.c 64 bit locking issues
Message-ID: <20010817164031.A6083@bacchus.dhis.org>
In-Reply-To: <200108160426.f7G4QaA19434@savage.trained-monkey.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200108160426.f7G4QaA19434@savage.trained-monkey.org>; from jes@trained-monkey.org on Thu, Aug 16, 2001 at 12:26:36AM -0400
X-Accept-Language: de,en,fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2001 at 12:26:36AM -0400, jes@trained-monkey.org wrote:

> The dz.c driver has an instance where it does save_flags() to a 32 bit
> type which isn't safe for 64 bit boxen.

It's safe because a MIPS only driver.

  Ralf
