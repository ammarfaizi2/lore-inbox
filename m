Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269474AbRHCQxV>; Fri, 3 Aug 2001 12:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269476AbRHCQxK>; Fri, 3 Aug 2001 12:53:10 -0400
Received: from adsl-64-166-241-227.dsl.snfc21.pacbell.net ([64.166.241.227]:23310
	"EHLO www.hockin.org") by vger.kernel.org with ESMTP
	id <S269474AbRHCQxI>; Fri, 3 Aug 2001 12:53:08 -0400
From: Tim Hockin <thockin@hockin.org>
Message-Id: <200108031639.f73GdJB23498@www.hockin.org>
Subject: Re: PCI bus speed
To: chen_xiangping@emc.com (chen, xiangping)
Date: Fri, 3 Aug 2001 09:39:19 -0700 (PDT)
Cc: todd@unm.edu ('Todd'), linux-kernel@vger.kernel.org
In-Reply-To: <276737EB1EC5D311AB950090273BEFDD043BC53A@elway.lss.emc.com> from "chen, xiangping" at Aug 03, 2001 10:27:10 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> yes. I see some items with flags listed as:
> 	Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 10    

I think that reflects the '66 MHz CAPABLE' bit.  That means that IFF every
device on the segment and IFF the bridge ALL can run at 66MHz, you MIGHT be
at 66 MHz.  Or anywhere between 33 and 66, or for that matter, less than
33.

Tim
