Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275595AbRIZU5l>; Wed, 26 Sep 2001 16:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275597AbRIZU5c>; Wed, 26 Sep 2001 16:57:32 -0400
Received: from NET.WAU.NL ([137.224.10.12]:58374 "EHLO net.wau.nl")
	by vger.kernel.org with ESMTP id <S275595AbRIZU50>;
	Wed, 26 Sep 2001 16:57:26 -0400
Date: Wed, 26 Sep 2001 22:57:49 +0200
From: Olivier Sessink <olivier@lx.student.wau.nl>
Subject: Re: Serious allocating/freeing memory or ReiserFS problem in 2.4.10
In-Reply-To: <1001472028.805.92.camel@instructor.localnet>; from cru@zodia.de
 on Wed, Sep 26, 2001 at 04:40:26AM +0200
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: cru@zodia.de
Message-id: <20010926225748.A20897@fender.fakenet>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-disposition: inline
X-MSMail-priority: High
User-Agent: Mutt/1.2.5i
X-System-Uptime: 10:44pm  up 45 days,  1:06,  1 user,  load average: 1.34,
 0.31, 0.10
X-Reverse-Engineered: High priority for sending SMS messages
In-Reply-To: <1001472028.805.92.camel@instructor.localnet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  0, Veit Wahlich <cru@zodia.de> wrote:
> Hi!
> 
> When I upgraded my kernel from 2.4.9 to 2.4.10 I experienced the problem
> described in this posting. Because I lack in time, I am not able to read
> this mailing list regularly, so I do not know whether this problem is
> known or not. Because I am short on time and this caused crashes on my
> system I can not apply any screenshots/hardcopys but I will try to help
> fetching information about this wherever I can. For this please contact
> cru@zodia.de .
> 
> I discovered this while using donkey (www.edonkey2000.com), a
> non-opensource P2P solution applying a Linux client. Contact is
> info@edonkey2000.com , I will forward this email to them.
> 
> As donkey is a MFTP implementation it begins to "hash" all incomplete
> files in the download queue when run. This means it reads the whole file
> and builds a kind of checksum (as I suppose) of all segments that are
> already downloaded. During this process, the amount of memory in use
> steadily grows, while the memory used by all processes (including
> donkey) stays nearly unchanged. Because I am running ReiserFS and donkey
> is reading huge files, this could also be a ReiserFS problem. I have no
> experience with donkey and kernels <2.4.9.

this is a problem specific to 2.4.10, I have the same problem (also using
edonkey), 2.4.10pre8 doesn't have this problem. I don't know what changed,
but 2.4.10 is not usable.

regards,
	Olivier

-- 
begin signature_virus.TXT.vbs
Hi, I'm a signature virus. plz set me as your signature and help me
spread :)
end

