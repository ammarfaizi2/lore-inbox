Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267939AbTBVWtq>; Sat, 22 Feb 2003 17:49:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267942AbTBVWtq>; Sat, 22 Feb 2003 17:49:46 -0500
Received: from to-wiznet.redhat.com ([216.129.200.2]:28145 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S267939AbTBVWtp>; Sat, 22 Feb 2003 17:49:45 -0500
Date: Sat, 22 Feb 2003 17:59:55 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Thomas Hofer <th@monochrom.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Box freezes if I enable "AMD 76x native power management"
Message-ID: <20030222175955.C5536@redhat.com>
References: <20030222163057.A884@namesys.com> <20030222185329.GA22170@morningstar.nowhere.lie> <200302222321.27820.th@monochrom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200302222321.27820.th@monochrom.at>; from th@monochrom.at on Sat, Feb 22, 2003 at 11:21:27PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 22, 2003 at 11:21:27PM +0100, Thomas Hofer wrote:
> With "AMD 76x native power management" I experienced freezes under X11 
> when the system was idle for about 30 min that usually went away when I 
> typed on the keyboard. Using the (USB) mouse had no effect. But I had 
> no problems at boot-time.

I've seen this too, but only in certain kernels.  Someone needs to take 
the time to binary search the pre patches to track down which one 
introduced the problem...

		-ben
-- 
Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>
