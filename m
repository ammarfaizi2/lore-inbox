Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422672AbWBIQhd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422672AbWBIQhd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 11:37:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422748AbWBIQhd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 11:37:33 -0500
Received: from webbox4.loswebos.de ([213.187.93.205]:48266 "EHLO
	webbox4.loswebos.de") by vger.kernel.org with ESMTP
	id S1422672AbWBIQhc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 11:37:32 -0500
Date: Thu, 9 Feb 2006 17:37:34 +0100
From: Marc Koschewski <marc@osknowledge.org>
To: Diego Calleja <diegocg@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, jes@sgi.com, pj@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: git for dummies, anyone?
Message-ID: <20060209163734.GB5710@stiffy.osknowledge.org>
References: <20060208070301.1162e8c3.pj@sgi.com> <yq0vevollx4.fsf@jaguar.mkp.net> <43EB4F05.8090400@pobox.com> <20060209163546.493334f8.diegocg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20060209163546.493334f8.diegocg@gmail.com>
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
X-Operating-System: Linux stiffy 2.6.16-rc2-marc-g0bdd340c-dirty
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Diego Calleja <diegocg@gmail.com> [2006-02-09 16:35:46 +0100]:

> El Thu, 09 Feb 2006 09:17:41 -0500,
> Jeff Garzik <jgarzik@pobox.com> escribió:
> 
> 
> > Check out:
> > http://linux.yyz.us/git-howto.html
> 
> That is a nice guide, but is oriented to developers, I think jes
> was asking from a user POV (I've needed to google for such things
> several times) ie how to switch to a given tag and return to master,
> how to update the repository periodically, etc; no stuff about how to
> manage patches. It may be nice to see such thing on your guide, something
> like this:
> 
> 
> - How to get a copy of linus'tree
>   git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> 
> - Update your copy:
>   cd linux-2.6; git pull; git pull --tags
> 
> - How to go back to a certain snapshot
>   git reset --hard v2.6.13 (ls .git/refs/tags to see all the tags). Not the
>   cleanest method, I think. "git-checkout -f master" will return to the "head"
>   of the repository. You can also pass commit-IDs to git-reset instead of tags?
> 
> - bisect search
>   git reset --hard BrokenVersion
>   git bisect start
>   git bisect good v2.6.13-rc2

I can be sooo easy. Thanks! ;)

Marc
