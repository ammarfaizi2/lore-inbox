Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267311AbTBENBK>; Wed, 5 Feb 2003 08:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267310AbTBENBK>; Wed, 5 Feb 2003 08:01:10 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:61861 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267311AbTBENBJ>;
	Wed, 5 Feb 2003 08:01:09 -0500
Date: Wed, 5 Feb 2003 13:07:07 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: b_adlakha@softhome.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: HYPERTHREADING on older P4???
Message-ID: <20030205130707.GA616@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	b_adlakha@softhome.net, linux-kernel@vger.kernel.org
References: <courier.3E410B73.000041C3@softhome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <courier.3E410B73.000041C3@softhome.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2003 at 06:02:43AM -0700, b_adlakha@softhome.net wrote:
 > hi,
 > /proc/cpuinfo reports "ht" in the supported options...I have a p4 2 ghz 
 > stepping 4, and when I boot with an SMP kernel, it shows another thing :
 > siblings 1 
 > 
 > I think HT is there in all p4s, so can it be enabled in older P4s? Like 
 > mine? What does "siblings = 1" mean? 
 
It means there is one 'thread'. Ergo, you do not have the possibility
of running this as you would a true HT P4.  There are a limited number
of Northwood P4's out there which do support HT and have >1 sibling,
but asides from those, you'll need a Xeon to take advantage of it.

There are countless rumours of being able to enable extra siblings
by poking MSRs, but not one person has to my knowledge achieved this.
Some folks have also allegedly found that snipping pins or wiring extra
bits to them have enabled the 'extra sibling'. Whether this is true or
not, and whether it is 100% equivalent to a real HT part is again,
questionable.

	Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
