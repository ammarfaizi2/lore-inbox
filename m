Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266556AbUBLT10 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 14:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266559AbUBLT10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 14:27:26 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:53003 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S266556AbUBLT1Y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 14:27:24 -0500
Content-Type: text/plain; charset=US-ASCII
From: Bill Davidsen <davidsen@oddball.prodigy.com>
Reply-To: davidsen@tmr.com
To: "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.2-mjb1
Date: Thu, 12 Feb 2004 14:31:19 -0500
User-Agent: KMail/1.4.1
Cc: linux-mm mailing list <linux-mm@kvack.org>
References: <30760000.1076532248@[10.10.2.4]>
In-Reply-To: <30760000.1076532248@[10.10.2.4]>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200402121431.19876.davidsen@oddball.prodigy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 11 February 2004 03:44 pm, Martin J. Bligh wrote:
> The patchset is meant to be pretty stable, not so much a testing ground.
> Main differences from mainline are:
>
> 1. Better performance & resource consumption, particularly on larger
> machines. 2. Diagnosis tools (kgdb, early_printk, etc).
> 3. Updated arch support for AMD64 + PPC64.
> 4. Better support for sound, especially OSS emulation over ALSA.
> 5. Better support for video (v4l2, bttv, ivtv).
> 6. Kexec support.
>
> I'd be very interested in feedback from anyone willing to test on any
> platform, however large or small.
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/mbligh/2.6.2/patch-2.6.2-mjb1.
>bz2
>
> Since 2.6.1-mjb1 (~ = changed, + = added, - = dropped)

The first thing I notice is that "make rpm" didn't work, and failed with the 
error code at the bottom of this message. Too bad, since I've been building 
RPMs on a big fast WBEL-3.0 four way Xeon, but have to run them on a humble 
PII-350. Forgive me, I do NOT want to build kernels on the test machine, it 
takes forever and needs a bit of temp space tweaking as well.

Built clean by itself, I just can't move and install it easily.

~~~~~~~~~~~~~~~~~~~~

+ umask 022
+ cd /usr/src/redhat/BUILD
+ LANG=C
+ export LANG
+ unset DISPLAY
+ exit 0
Executing(%build): /bin/sh -e /var/tmp/rpm-tmp.33180
+ umask 022
+ cd /usr/src/redhat/BUILD
+ LANG=C
+ export LANG
+ unset DISPLAY
+ rm -rf /tmp/lpfc-LPFC_DRIVER_VERSION
+ mkdir -p /tmp/lpfc-LPFC_DRIVER_VERSION/lpfc-LPFC_DRIVER_VERSION
+ cd lpfc-LPFC_DRIVER_VERSION
/var/tmp/rpm-tmp.33180: line 28: cd: lpfc-LPFC_DRIVER_VERSION: No such file or 
directory
error: Bad exit status from /var/tmp/rpm-tmp.33180 (%build)


RPM build errors:
    Bad exit status from /var/tmp/rpm-tmp.33180 (%build)
make: *** [rpm] Error 1

-- 
Bill Davidsen, TMR
