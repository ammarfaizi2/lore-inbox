Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269408AbRHCPja>; Fri, 3 Aug 2001 11:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269414AbRHCPjU>; Fri, 3 Aug 2001 11:39:20 -0400
Received: from u-54-20.karlsruhe.ipdial.viaginterkom.de ([62.180.20.54]:35467
	"EHLO dea.waldorf-gmbh.de") by vger.kernel.org with ESMTP
	id <S269408AbRHCPjH>; Fri, 3 Aug 2001 11:39:07 -0400
Date: Fri, 3 Aug 2001 15:32:31 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: "chen, xiangping" <chen_xiangping@emc.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI bus speed
Message-ID: <20010803153231.A28624@bacchus.dhis.org>
In-Reply-To: <276737EB1EC5D311AB950090273BEFDD043BC536@elway.lss.emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <276737EB1EC5D311AB950090273BEFDD043BC536@elway.lss.emc.com>; from chen_xiangping@emc.com on Thu, Aug 02, 2001 at 06:47:49PM -0400
X-Accept-Language: de,en,fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2001 at 06:47:49PM -0400, chen, xiangping wrote:

> Is there any easy way to probe the PCI bus speed of an Intel box?

You can find about PCI33 or PCI66 standards but there is no way to find
the exact clock rate the PCI bus is actually clocked at.  Which is a
problem with certain non-compliant cards; the IOC3 card and a few others
derive internal clocks from the PCI bus clock rate so will not properly
work if operated on a bus with different clock rate.

  Ralf
