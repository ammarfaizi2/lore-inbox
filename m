Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261560AbVDWMUv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261560AbVDWMUv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 08:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261561AbVDWMUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 08:20:51 -0400
Received: from mail.aei.ca ([206.123.6.14]:45308 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S261560AbVDWMUq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 08:20:46 -0400
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Linux 2.6.12-rc3
Date: Sat, 23 Apr 2005 08:21:23 -0400
User-Agent: KMail/1.7.2
Cc: Pavel Machek <pavel@ucw.cz>, Petr Baudis <pasky@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0504201728110.2344@ppc970.osdl.org> <20050422231839.GC1789@elf.ucw.cz> <Pine.LNX.4.58.0504221718410.2344@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504221718410.2344@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504230821.24884.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 22 April 2005 20:21, Linus Torvalds wrote:
> 
> On Sat, 23 Apr 2005, Pavel Machek wrote:
> > 
> > Unfortunately first merge will make it practically unusable :-(. 
> 
> No, quite the reverse. If I merge from you, and you use my commit ID as 
> the "base" point, it will work again.
> 
> But yes, if you actually send the result as _patches_ to me, then the 
> commit objects I create will be totally separate from the commit objects 
> you had in your tree, and "git-export" will continue to export your old 
> stale entries since they won't show up as already being in my tree.
> 
> The point being, that there is a big difference between a proper merge 
> (with history etc merged) and just sending me the patches in your tree.

Using git patch, the output has the commit id.  Could this be used during
a merge of patches to record info that the source git could use to recognize
the changes as ones it originated (after a pull from the remote git which has
the merged patches)?

Ed Tomlinson
