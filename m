Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129771AbRCGBCp>; Tue, 6 Mar 2001 20:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129795AbRCGBCg>; Tue, 6 Mar 2001 20:02:36 -0500
Received: from [209.102.105.34] ([209.102.105.34]:47628 "EHLO monza.monza.org")
	by vger.kernel.org with ESMTP id <S129771AbRCGBC0>;
	Tue, 6 Mar 2001 20:02:26 -0500
Date: Tue, 6 Mar 2001 17:01:02 -0800
From: Tim Wright <timw@splhi.com>
To: Ettore Perazzoli <ettore@ximian.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Interesting fs corruption story
Message-ID: <20010306170102.B1095@kochanski.internal.splhi.com>
Reply-To: timw@splhi.com
Mail-Followup-To: Ettore Perazzoli <ettore@ximian.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0103042043320.27829-100000@trna.ximian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0103042043320.27829-100000@trna.ximian.com>; from ettore@ximian.com on Sun, Mar 04, 2001 at 09:46:19PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ettore,
I have no idea if this is related to your problem since you didn't mention
that key part, but with the same drive, I managed to trash my root partition
incredibly badly by trying to use DMA and then do APM suspend or hibernate.
On wakeup, I'd get an 'hda: lost interrupt' but then things would appear to
carry on.

The fix for me was to rebuild the kernel and make sure CONFIG_APM_ALLOW_INTS
was enabled. So, do you ever use power management and is this similar, or do
you have a completely different problem ?

Tim

-- 
Tim Wright - timw@splhi.com or timw@aracnet.com or twright@us.ibm.com
IBM Linux Technology Center, Beaverton, Oregon
Interested in Linux scalability ? Look at http://lse.sourceforge.net/
"Nobody ever said I was charming, they said "Rimmer, you're a git!"" RD VI
