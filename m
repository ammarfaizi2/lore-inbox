Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314401AbSDRSW0>; Thu, 18 Apr 2002 14:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314402AbSDRSWZ>; Thu, 18 Apr 2002 14:22:25 -0400
Received: from khms.westfalen.de ([62.153.201.243]:44725 "EHLO
	khms.westfalen.de") by vger.kernel.org with ESMTP
	id <S314401AbSDRSWY>; Thu, 18 Apr 2002 14:22:24 -0400
Date: 18 Apr 2002 20:16:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8N7App8mw-B@khms.westfalen.de>
In-Reply-To: <20020418135931.GU21206@holomorphy.com>
Subject: Re: [RFC] 2.5.8 sort kernel tables
X-Mailer: CrossPoint v3.12d.kh9 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

wli@holomorphy.com (William Lee Irwin III)  wrote on 18.04.02 in <20020418135931.GU21206@holomorphy.com>:

> On Thu, Apr 18, 2002 at 07:46:26PM +1000, Keith Owens wrote:
> > The use of __init and __exit sections breaks the assumption that tables
> > such as __ex_table are sorted, it has already broken the dbe table in
> > mips on 2.5.  This patch against 2.5.8 adds a generic sort routine and
> > sorts the i386 exception table.
> > This sorting needs to be extended to several other tables, to all
> > architectures, to modutils (insmod loads some of these tables for
> > modules) and back ported to 2.4.  Before I spend the rest of the time,
> > any objections?
>
> It doesn't have to be an O(n lg(n)) method but could you use something
> besides bubblesort? Insertion sort, selection sort, etc. are just as
> easy and they don't have the horrific stigma of being "the worst sorting
> algorithm ever" etc.

Surely the worst (working) sort is randomsort? (Check if sorted. If not,  
pick two entries at random, exchange, retry.)

MfG Kai
