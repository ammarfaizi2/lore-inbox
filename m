Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269086AbUHYBWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269086AbUHYBWM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 21:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269091AbUHYBWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 21:22:12 -0400
Received: from fw.osdl.org ([65.172.181.6]:9424 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269086AbUHYBVN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 21:21:13 -0400
Date: Tue, 24 Aug 2004 18:20:56 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Daniel Andersen <anddan@linux-user.net>
cc: "Sartorelli, Kevin" <Kevin.Sartorelli@openpolytechnic.ac.nz>,
       fraga@abusar.org, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.9-rc1
In-Reply-To: <412BE5CC.8020303@linux-user.net>
Message-ID: <Pine.LNX.4.58.0408241818030.17766@ppc970.osdl.org>
References: <4B2093FFC31B7A45862B62A376EA7176033C058D@mickey.topnz.ac.nz>
 <412BE5CC.8020303@linux-user.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 25 Aug 2004, Daniel Andersen wrote:
>
>					 Linus, is there a chance that 
> there will be a x.y.z.W release of an old kernel after the next x.y.Z.w 
> has been released and no longer is -rc? For example releasing a 2.6.8.2 
> after 2.6.9 has been released and no longer is a 2.6.9-rcX.

I don't see the point of such a release, so I'd say "no". Once we have a 
stable kernel, we make updates to _that_ one, not older ones.

HOWEVER - there may well be exceptions to this brought on by distribution 
usage etc. For example, if some distribution ends up basing it's work on 
(say) 2.6.8.1, and we later find a bug, we might release a 2.6.8.2 even 
though we might have done a 2.6.9 or even 2.6.10 later - just as a way to 
support the existing users who take a long time to update.

I consider that a pretty remote possibility, though. It's a lot more 
likely that the distribution-maker itself just does it's own patch on top 
of whatever release he started off with.

		Linus
