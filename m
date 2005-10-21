Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751251AbVJUVo0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbVJUVo0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 17:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbVJUVo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 17:44:26 -0400
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:63543 "EHLO
	mta08-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751251AbVJUVoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 17:44:25 -0400
Date: Fri, 21 Oct 2005 22:44:22 +0100 (BST)
From: Ken Moffat <zarniwhoop@ntlworld.com>
To: Steve Youngs <steve@youngs.au.com>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Ken Moffat <zarniwhoop@ntlworld.com>
Subject: Re: 2.6.13.4 After increasing RAM, I'm getting Bad page state at
 prep_new_page
In-Reply-To: <microsoft-free.87pspybm4d.fsf@youngs.au.com>
Message-ID: <Pine.LNX.4.63.0510212233140.26585@deepthought.mydomain>
References: <microsoft-free.877jc9jzwy.fsf@youngs.au.com>
 <Pine.LNX.4.63.0510191730570.23833@deepthought.mydomain>
 <microsoft-free.87pspybm4d.fsf@youngs.au.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463809536-424337779-1129931062=:26585"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463809536-424337779-1129931062=:26585
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN; format=flowed
Content-Transfer-Encoding: 8BIT

On Sat, 22 Oct 2005, Steve Youngs wrote:

>
> I gave memtest86+ a shot, and after about 18 hours it came up with...
>
>  Test:            8
>  Pass:            7
>  Failing Address: 00008072bf0 - 128.1MB
>  Good:            00000000
>  Bad:             00000100
>  Err-Bits:        00000100
>  Count:           1
>
>  >  3GB sounds an awful lot for an athlon - 2x1GB and 2x512MB, I suppose.
>
> 3x1GB
>

  At least the problem showed up, so the load on the power supply is not 
a prime concern.

  If you have the patience, first take out one of the 'good' sticks and 
repeat with 2x1GB.  If that works, it's probable the mobo can't drive 
3x1GB, at least with the chip arrangement on those particular sticks. 
OTOH, if it still fails at that address, perhaps that one stick is 
suspect - in that case try swapping it and retesting.

  Of course, if your manual is unclear about which slot maps where, you 
might have to try permutations of 2 sticks on this approach.  And that's 
before messing with obscure and poorly-explained bios options to control 
the memory timing and drive.  Good Luck!

Ken
-- 
  das eine Mal als Tragödie, das andere Mal als Farce

---1463809536-424337779-1129931062=:26585--
