Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269476AbRHCQ7c>; Fri, 3 Aug 2001 12:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269477AbRHCQ7W>; Fri, 3 Aug 2001 12:59:22 -0400
Received: from adsl-64-166-241-227.dsl.snfc21.pacbell.net ([64.166.241.227]:27662
	"EHLO www.hockin.org") by vger.kernel.org with ESMTP
	id <S269476AbRHCQ7J>; Fri, 3 Aug 2001 12:59:09 -0400
From: Tim Hockin <thockin@hockin.org>
Message-Id: <200108031642.f73GgbL23675@www.hockin.org>
Subject: Re: PCI bus speed
To: ralf@uni-koblenz.de (Ralf Baechle)
Date: Fri, 3 Aug 2001 09:42:37 -0700 (PDT)
Cc: chen_xiangping@emc.com (chen xiangping), linux-kernel@vger.kernel.org
In-Reply-To: <20010803153231.A28624@bacchus.dhis.org> from "Ralf Baechle" at Aug 03, 2001 03:32:31 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Aug 02, 2001 at 06:47:49PM -0400, chen, xiangping wrote:
> 
> > Is there any easy way to probe the PCI bus speed of an Intel box?
> 
> You can find about PCI33 or PCI66 standards but there is no way to find
> the exact clock rate the PCI bus is actually clocked at.  Which is a
> problem with certain non-compliant cards; the IOC3 card and a few others
> derive internal clocks from the PCI bus clock rate so will not properly
> work if operated on a bus with different clock rate.


Also, many IDE controllers do this.  GACK!

