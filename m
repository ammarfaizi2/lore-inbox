Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751115AbWHBDyZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbWHBDyZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 23:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbWHBDyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 23:54:24 -0400
Received: from 63-162-81-179.lisco.net ([63.162.81.179]:43653 "EHLO
	grunt.slaphack.com") by vger.kernel.org with ESMTP id S1751115AbWHBDyX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 23:54:23 -0400
Message-ID: <44D021EE.1040907@slaphack.com>
Date: Tue, 01 Aug 2006 23:54:22 -0400
From: David Masover <ninja@slaphack.com>
User-Agent: Thunderbird 1.5.0.5 (Macintosh/20060719)
MIME-Version: 1.0
To: Nate Diller <nate.diller@gmail.com>
CC: "Vladimir V. Saveliev" <vs@namesys.com>, Andrew Morton <akpm@osdl.org>,
       vda.linux@googlemail.com, linux-kernel@vger.kernel.org,
       Reiserfs-List@namesys.com
Subject: Re: reiser4: maybe just fix bugs?
References: <1158166a0607310226m5e134307o8c6bedd1f883479c@mail.gmail.com>	 <20060801013104.f7557fb1.akpm@osdl.org> <44CEBA0A.3060206@namesys.com>	 <1154431477.10043.55.camel@tribesman.namesys.com>	 <20060801073316.ee77036e.akpm@osdl.org>	 <1154444822.10043.106.camel@tribesman.namesys.com>	 <44CF879D.1000803@slaphack.com> <5c49b0ed0608011226w328d809fy9d50aa785ad93536@mail.gmail.com>
In-Reply-To: <5c49b0ed0608011226w328d809fy9d50aa785ad93536@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nate Diller wrote:
> On 8/1/06, David Masover <ninja@slaphack.com> wrote:
>> Vladimir V. Saveliev wrote:

>> I could be entirely wrong, though.  I speak for neither
>> Hans/Namesys/reiserfs nor LKML.  Talk amongst yourselves...
> 
> i should clarify things a bit here.  yes, hans' goal is for there to
> be no difference between the "xattr" namespace and the "readdir" one.
> unfortunately, this is not feasible with the current VFS, and some
> major work would have to be done to enable this without some
> pathological cases cropping up.  some very smart people think that it
> cannot be done at all.

But an xattr interface should work just fine, even if the rest of the 
system is inaccessible (no readdir interface) -- preventing all these 
pathological problems, except the one where Hans implements it the way 
I'm thinking, and kernel people hate it.
