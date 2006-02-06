Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932408AbWBFWi4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932408AbWBFWi4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 17:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932409AbWBFWi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 17:38:56 -0500
Received: from smtpout.mac.com ([17.250.248.88]:57311 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932408AbWBFWiz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 17:38:55 -0500
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKGECCJPAB.davids@webmaster.com>
References: <MDEHLPKNGKAHNMBLJOLKGECCJPAB.davids@webmaster.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <50968728-E8BA-46BB-83D9-866ADEE546DA@mac.com>
Cc: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: GPL V3 and Linux - Dead Copyright Holders
Date: Mon, 6 Feb 2006 17:38:51 -0500
To: davids@webmaster.com
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 06, 2006, at 16:07, David Schwartz wrote:
>> The LGPL deals with only derivative works. The GPL also deals with  
>> mere *linking*. If glibc were GPL'd, it would be illegal to make  
>> an OS based on it with a single C program incompatible with the GPL.
>
> The only way the GPL can control work Y because it affects work Z  
> is because Y is a derivative work of work Z. If it's not, then the  
> works are legally unrelated, and no matter what the GPL says, it  
> can't affect work Y.

To say this more simplistically, the LGPL essentially says "Even if  
dynamic linking constitutes making a derivative work, we allow you to  
dynamically link, so long as the rules are followed for the LGPL code  
to which you link".  The GPL essentially says "If dynamic linking is  
making a derivative work, then these rules apply to the whole  
derivative work and all of its constituent parts".

Whether or not an NVidia binary module is a derivative work is left  
up to the courts to decide.  It _may_ be legal (don't trust me,  
consult your lawyer) to have a very simple cross-platform interface  
and some BSD-licensed glue.  On the other hand, if your interface  
derives from or exposes any kind of kernel-internals, then it is most  
certainly a derivative work (because you can't argue that the binary  
interface was written to be independent of Linux, and it therefore  
falls under the GPL.

Cheers,
Kyle Moffett

--
Unix was not designed to stop people from doing stupid things,  
because that would also stop them from doing clever things.
   -- Doug Gwyn


