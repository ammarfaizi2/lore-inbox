Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317635AbSGJVkI>; Wed, 10 Jul 2002 17:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317636AbSGJVkH>; Wed, 10 Jul 2002 17:40:07 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:34293 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S317635AbSGJVkG>; Wed, 10 Jul 2002 17:40:06 -0400
Date: Wed, 10 Jul 2002 17:42:51 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: "Grover, Andrew" <andrew.grover@intel.com>,
       Linux <linux-kernel@vger.kernel.org>
Subject: Re: HZ, preferably as small as possible
Message-ID: <20020710174251.E2005@redhat.com>
References: <59885C5E3098D511AD690002A5072D3C02AB7F88@orsmsx111.jf.intel.com> <3D2CA6E3.CB5BC420@zip.com.au> <20020710173555.D2005@redhat.com> <3D2CA958.BEE16D98@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D2CA958.BEE16D98@zip.com.au>; from akpm@zip.com.au on Wed, Jul 10, 2002 at 02:38:32PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2002 at 02:38:32PM -0700, Andrew Morton wrote:
> OK, I'll grant that.  Why is this useful?

Think video playback, where you want to queue the frame to be played as 
close to the correct 1/60s time as possible.  With HZ=100, the code will 
frequently wake up much too late.

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."
