Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030183AbVKBWst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030183AbVKBWst (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 17:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030182AbVKBWst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 17:48:49 -0500
Received: from mail16.syd.optusnet.com.au ([211.29.132.197]:477 "EHLO
	mail16.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1030184AbVKBWss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 17:48:48 -0500
From: Con Kolivas <kernel@kolivas.org>
To: ck@vds.kolivas.org
Subject: Re: [ck] 2.6.14-ck1
Date: Thu, 3 Nov 2005 09:51:00 +1100
User-Agent: KMail/1.8.3
Cc: Predrag Ivanovic <predivan@ptt.yu>, linux-kernel@vger.kernel.org,
       wfg@mail.ustc.edu.cn
References: <200510282118.11704.kernel@kolivas.org> <20051102213814.15724994.predivan@ptt.yu>
In-Reply-To: <20051102213814.15724994.predivan@ptt.yu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511030951.00679.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Nov 2005 07:38 am, Predrag Ivanovic wrote:
> On Fri, 28 Oct 2005 21:18:09 +1000
> Con Kolivas wrote:
>
> <snip>
>
> > Changes:
> >
> > Added:
> > +adaptive-readahead-4.patch
> > We Fengguang's adaptive readahead patch. Please test and report
> > experiences - Wu has been cc'ed on this email, please keep him cc'ed
> > for reports.
>
> Con,any recommended value for /proc/sys/kernel/readahead_ratio,
> or is it automagicly set?It's value is 0 ATM.

Yes. First it's supposed to be in /proc/sys/vm (my fault on the merge), and it 
should be set to about 50. All this is corrected in 2.6.14-ck2 which has the 
new readahead code, the tunable in the correct location, and the default set 
to 50. 

> Great work with ck.BTW :-)

Thanks!

Cheers,
Con
