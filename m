Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317889AbSGKTti>; Thu, 11 Jul 2002 15:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317892AbSGKTti>; Thu, 11 Jul 2002 15:49:38 -0400
Received: from zok.SGI.COM ([204.94.215.101]:48776 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S317889AbSGKTtg>;
	Thu, 11 Jul 2002 15:49:36 -0400
Date: Thu, 11 Jul 2002 12:52:21 -0700
From: Jesse Barnes <jbarnes@sgi.com>
To: Lincoln Dale <ltd@cisco.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: direct-to-BIO for O_DIRECT
Message-ID: <20020711195221.GA709012@sgi.com>
Mail-Followup-To: Lincoln Dale <ltd@cisco.com>,
	lkml <linux-kernel@vger.kernel.org>
References: <3D2904C5.53E38ED4@zip.com.au> <5.1.0.14.2.20020711122101.021a5590@mira-sjcm-3.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.1.0.14.2.20020711122101.021a5590@mira-sjcm-3.cisco.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2002 at 12:25:03PM +1000, Lincoln Dale wrote:
> sorry for the delay.
> upgrading from 2.4.19 to 2.5.25 took longer than expected, since the
> QLogic FC 2300 HBA driver isn't part of the standard kernel, and i
> had to update it to reflect the io_request_lock -> host->host_lock,
> kdev_t and kbuild changes.  urgh, pain pain pain.  in the process, i
> discovered some races in their driver, so fixed them also.

So you ported the qla2x00 driver forward to 2.5?  Would it be possible
to post that driver?  Not having it has held up some testing I'd like
to do...

Thanks,
Jesse
