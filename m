Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268005AbUHYOzL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268005AbUHYOzL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 10:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267985AbUHYOyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 10:54:40 -0400
Received: from jade.spiritone.com ([216.99.193.136]:19435 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S266262AbUHYOwu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 10:52:50 -0400
Date: Wed, 25 Aug 2004 07:52:29 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@osdl.org>,
       Daniel Andersen <anddan@linux-user.net>
cc: "Sartorelli, Kevin" <Kevin.Sartorelli@openpolytechnic.ac.nz>,
       fraga@abusar.org, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.9-rc1
Message-ID: <147680000.1093445547@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.58.0408241818030.17766@ppc970.osdl.org>
References: <4B2093FFC31B7A45862B62A376EA7176033C058D@mickey.topnz.ac.nz><412BE5CC.8020303@linux-user.net> <Pine.LNX.4.58.0408241818030.17766@ppc970.osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>					 Linus, is there a chance that 
>> there will be a x.y.z.W release of an old kernel after the next x.y.Z.w 
>> has been released and no longer is -rc? For example releasing a 2.6.8.2 
>> after 2.6.9 has been released and no longer is a 2.6.9-rcX.
> 
> I don't see the point of such a release, so I'd say "no". Once we have a 
> stable kernel, we make updates to _that_ one, not older ones.
> 
> HOWEVER - there may well be exceptions to this brought on by distribution 
> usage etc. For example, if some distribution ends up basing it's work on 
> (say) 2.6.8.1, and we later find a bug, we might release a 2.6.8.2 even 
> though we might have done a 2.6.9 or even 2.6.10 later - just as a way to 
> support the existing users who take a long time to update.
> 
> I consider that a pretty remote possibility, though. It's a lot more 
> likely that the distribution-maker itself just does it's own patch on top 
> of whatever release he started off with.

My assumption would be that once 2.6.9 is released, it's not uber-stable
immediately ... so it'd be nice to keep at least one minor rev back
going on the bugfix stream (eg 2.6.8.X) .... for people who want an 
uber-stable kernel. Doing more than 1 back would indeed seem 
counter-productive.

That said it's unlikely there would still be urgent fixes for 2.6.8 a few
weeks after it was released, but it seems like the right thing to do, at
least in principle (maybe for a security fix, or something).

M.

