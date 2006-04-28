Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751056AbWD1TUT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbWD1TUT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 15:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbWD1TUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 15:20:19 -0400
Received: from washoe.rutgers.edu ([165.230.95.67]:35538 "EHLO
	washoe.rutgers.edu") by vger.kernel.org with ESMTP id S1751056AbWD1TUS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 15:20:18 -0400
Date: Fri, 28 Apr 2006 15:20:17 -0400
From: Yaroslav Halchenko <kernel@onerussian.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       woodys@xandros.com
Subject: Re: Highpoint SATA RAID (khe khe) status -- oopses, crashes, etc
Message-ID: <20060428192017.GH17639@washoe.onerussian.com>
Mail-Followup-To: linux kernel mailing list <linux-kernel@vger.kernel.org>,
	woodys@xandros.com
References: <20060425172356.GD15201@washoe.onerussian.com> <20060426190657.GA17639@washoe.onerussian.com> <20060427053528.GB17639@washoe.onerussian.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060427053528.GB17639@washoe.onerussian.com>
X-URL: http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: 3BB6 E124 0643 A615 6F00  6854 8D11 4563 75C0 24C8
User-Agent: mutt-ng/devel-r782 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Woody and the others,

Is there anything else we could try to make this damn hpt366 work to
somewhat better extent? now 700kBps is too slow -- I just gave up
waiting while it would rebuild RAID1 on those two drives. and that also
slowed down another RAID present in the system (nice Areca one)

> Alan Cox's newest and greatest ide-on-sata falls back to the 33MHz
> timings
Isn't what it the libata implementation which oopsed? May be I should
try older "Support for SATA", but kernel menu item says that it
conflicts with libata SATA driver, so I am not sure how stable that
solution will be either... but I know that on 2.6.7 there were no
problem detecting the beast

I am not much of a kernel hacker that is why my question is so vague...
but many be I can be of some help if pointed to the right direction

Thank you in advance
-- 
Yaroslav Halchenko
Research Assistant, Psychology Department, Rutgers-Newark
Office: (973) 353-5440x263 | FWD: 82823 | Fax: (973) 353-1171
        101 Warren Str, Smith Hall, Rm 4-105, Newark NJ 07105
Student  Ph.D. @ CS Dept. NJIT
