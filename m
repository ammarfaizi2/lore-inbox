Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750823AbVIBSfQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbVIBSfQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 14:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbVIBSfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 14:35:16 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:25047 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750823AbVIBSfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 14:35:14 -0400
Subject: Re: IDE HPA
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: pjones@redhat.com
Cc: "ATARAID (eg, Promise Fasttrak, Highpoint 370) related discussions" 
	<ataraid-list@redhat.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1125684567.31292.2.camel@localhost.localdomain>
References: <87941b4c05082913101e15ddda@mail.gmail.com>
	 <87941b4c05083008523cddbb2a@mail.gmail.com>
	 <1125419927.8276.32.camel@localhost.localdomain>
	 <87941b4c050830095111bf484e@mail.gmail.com>
	 <62b0912f0509020027212e6c42@mail.gmail.com>
	 <1125666332.30867.10.camel@localhost.localdomain>
	 <62b0912f05090206331d04afd3@mail.gmail.com>
	 <E1EBCdS-00064p-00@chiark.greenend.org.uk>
	 <62b0912f05090209242ad72321@mail.gmail.com>
	 <1125680712.30867.20.camel@localhost.localdomain>
	 <62b0912f05090210441d3fa248@mail.gmail.com>
	 <1125684567.31292.2.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 02 Sep 2005 19:59:17 +0100
Message-Id: <1125687557.30867.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-09-02 at 14:09 -0400, Peter Jones wrote:
> (if there's already a straightforward way, feel free to clue me in --
> but the default should almost certainly be to assume the HPA is set up
> correctly, shouldn't it?)

The normal use of HPA is to clip drives to get them past BIOS boot
checks. The thinkpads come with a pre-installed partition table which
will protect the HPA unless the user goes to town removing it.

The ideal case would be that the partition table is considered at boot
to see if the HPA matches the partitiont table or not. You'd also then
need dynamic HPA enable/disable for installers and other tools to go
with that.

Send patches.

