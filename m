Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291218AbSBGSus>; Thu, 7 Feb 2002 13:50:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291231AbSBGSui>; Thu, 7 Feb 2002 13:50:38 -0500
Received: from ns.suse.de ([213.95.15.193]:63501 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S291218AbSBGSu3>;
	Thu, 7 Feb 2002 13:50:29 -0500
Date: Thu, 7 Feb 2002 19:50:28 +0100
From: Dave Jones <davej@suse.de>
To: Brian Strand <bstrand@switchmanagement.com>
Cc: John Weber <weber@nyc.rr.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: PCI Hotplug and Linux 2.5.4-pre2
Message-ID: <20020207195028.O22451@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Brian Strand <bstrand@switchmanagement.com>,
	John Weber <weber@nyc.rr.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3C62C4AB.3040109@nyc.rr.com> <3C62C831.9010302@switchmanagement.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C62C831.9010302@switchmanagement.com>; from bstrand@switchmanagement.com on Thu, Feb 07, 2002 at 10:32:17AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2002 at 10:32:17AM -0800, Brian Strand wrote:

 > I vote yes; I always turn on as many modularizable chunks as possible, 
 > to increase "compile coverage".  And we all know if it compiles, it 
 > works, right?

 I hope that was sarcasm 8-) Some things such as the NCR5380 'fixes'
 in Linus tree have put the driver into a state where it compiles and
 maybe even runs, but it's almost guaranteed to corrupt.  There's
 a more complete set of fixes for some of these problems in my tree,
 but alas, doesn't compile..

 Numerous other bio related problems have been reported and had
 'quick fixes' offered for them which turn out to be worse than
 a non-compiling driver.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
