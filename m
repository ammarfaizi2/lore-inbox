Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319049AbSIDErY>; Wed, 4 Sep 2002 00:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319050AbSIDErY>; Wed, 4 Sep 2002 00:47:24 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:38130 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S319049AbSIDErY>; Wed, 4 Sep 2002 00:47:24 -0400
Date: Tue, 03 Sep 2002 21:49:58 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
cc: colpatch@us.ibm.com
Subject: Re: [BUG] 2.5.33 PCI and/or starfire.c broken
Message-ID: <99179272.1031089797@[10.10.2.3]>
In-Reply-To: <20020904035649.GC18800@holomorphy.com>
References: <20020904035649.GC18800@holomorphy.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, something ugly has happened no 2.5.33's PCI:
> 
> Somehow SCSI works, but starfire.c doesn't.

It's confused by having a PCI-PCI bridge on a quad other than 0,
where the global and local PCI bus numbers don't line up. Rip
the card out, or get the horrible kludge I did for 2.4, and use 
that.

M.

