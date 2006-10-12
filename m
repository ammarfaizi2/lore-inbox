Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751416AbWJLRGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbWJLRGN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 13:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbWJLRGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 13:06:13 -0400
Received: from terminus.zytor.com ([192.83.249.54]:39337 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751421AbWJLRGL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 13:06:11 -0400
Message-ID: <452E758E.2060701@zytor.com>
Date: Thu, 12 Oct 2006 10:04:14 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: John Coffman <johninsd@san.rr.com>
CC: Alexander van Heukelum <heukelum@mailshack.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       Linus Torvalds <torvalds@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] Remove  lilo-loads-only-five-sectors-of-zImage-fixup
 from setup.S
References: <20061011163356.GA2022@mailshack.com> <452D3A11.5020100@zytor.com> <20061011194301.GA2084@mailshack.com> <6.2.3.4.0.20061012095229.048db398@pop-server.san.rr.com>
In-Reply-To: <6.2.3.4.0.20061012095229.048db398@pop-server.san.rr.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Coffman wrote:
> Alexander,
> 
> You are referring to versions of LILO more than 8 years old.  Since 
> version 21, when I took over maintenance from Werner, LILO has been 
> sensitive to the boot protocol in use.  Peter has been kind enough to 
> point out upgrades to the 2.00+ protocols when they have been introduced.
> 
> All versions of LILO since version 21 should be able to correctly handle 
> both zImage and bzImage kernels, old and new.  The command:  "lilo -V 
> -v" should indicate the version of LILO you are using, and may indicate 
> a release date.
> 

We're talking old enough that it didn't support either bzImage or initrd.

	-hpa

