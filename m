Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267471AbSLFAzi>; Thu, 5 Dec 2002 19:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267476AbSLFAzh>; Thu, 5 Dec 2002 19:55:37 -0500
Received: from ip68-4-86-174.oc.oc.cox.net ([68.4.86.174]:20468 "EHLO
	ip68-4-86-174.oc.oc.cox.net") by vger.kernel.org with ESMTP
	id <S267471AbSLFAzh>; Thu, 5 Dec 2002 19:55:37 -0500
Date: Thu, 5 Dec 2002 17:03:12 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: Robert Love <rml@tech9.net>
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: 2.5: ext3 bug or dying drive?
Message-ID: <20021206010312.GC17498@ip68-4-86-174.oc.oc.cox.net>
References: <1039123660.1433.12.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1039123660.1433.12.camel@phantasy>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2002 at 04:27:40PM -0500, Robert Love wrote:
> IBM U2W drive on a 2940U2W if it matters.  UP kernel.

http://www.storage.ibm.com/hdd/support/download.htm

Download the Drive Fitness Test "Linux disk creator" (which isn't
actually a "disk creator" like the Windows version, but simply a file
you dd onto a 1.44MB floppy), then boot off that and try the Quick test.
If that doesn't show anything wrong, try the Advanced test or whatever
the longer one is called.

If DFT doesn't fail outright and instead offers to erase part of the
drive for you to "repair" it, that means there are bad sectors.
Conversely, if the Advanced test shows Disposition Code 00, that means
the drive is probably OK. (I think another way of interpreting the
results is that OK results are text on a green background, and failures
are text on red.) Anyway, this stuff will seem more obvious once you try
it.

-Barry K. Nathan <barryn@pobox.com>
