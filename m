Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278078AbRKNVuZ>; Wed, 14 Nov 2001 16:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278046AbRKNVuP>; Wed, 14 Nov 2001 16:50:15 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:64839 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S278042AbRKNVuC>; Wed, 14 Nov 2001 16:50:02 -0500
Date: Wed, 14 Nov 2001 16:49:57 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: "Peter T. Breuer" <ptb@it.uc3m.es>, dalecki@evision.ag,
        linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: blocks or KB? (was: .. current meaning of blk_size array)
Message-ID: <20011114164957.A7587@redhat.com>
In-Reply-To: <3BF23D01.F7E879E8@evision-ventures.com> <200111142041.fAEKfBN15594@oboe.it.uc3m.es> <20011114141639.P5739@lynx.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011114141639.P5739@lynx.no>; from adilger@turbolabs.com on Wed, Nov 14, 2001 at 02:16:39PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2001 at 02:16:39PM -0700, Andreas Dilger wrote:
> Well, the rumor is wrong.  There has always been a single-device 1TB/2TB
> limit in the kernel (2^31 or 2^32 * 512 byte sector size), and until
> recently it has not been a problem.  To remove the problem Jens Axboe
> (I think, or Ben LaHaise, can't remember) has a patch to support 64-bit
> block counts and has been tested with > 2TB devices.

It was tested with a 10TB loopback raid, not a real device.  Strangly, 
nobody made any effort to test on real physical hardware (or offer any 
hardware for me to test on ;-).  The patch was against ~2.4.6 and will 
need to get dusted off again soon.

		-ben
-- 
Fish.
