Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750915AbWC1Mxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750915AbWC1Mxy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 07:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbWC1Mxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 07:53:54 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:11693 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750915AbWC1Mxx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 07:53:53 -0500
Date: Tue, 28 Mar 2006 06:53:42 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, devel@openvz.org, serue@us.ibm.com,
       akpm@osdl.org, sam@vilain.net, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Pavel Emelianov <xemul@sw.ru>, Stanislav Protassov <st@sw.ru>
Subject: Re: [RFC] Virtualization steps
Message-ID: <20060328125342.GB12264@sergelap.austin.ibm.com>
References: <44242A3F.1010307@sw.ru> <20060324211917.GB22308@MAIL.13thfloor.at> <m1psk7enfm.fsf@ebiederm.dsl.xmission.com> <4428F902.1020706@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4428F902.1020706@sw.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kirill Korotaev (dev@sw.ru):
> >>so IMHO, we should make a kernel branch (Eric or Sam
> >>are probably willing to maintain that), which we keep
> >>in-sync with mainline (not necessarily git, but at 
> >>least snapshot wise), where we put all the patches
> >>we agree on, and each party should then adjust the
> >>existing solution to this kernel, so we get some deep
> >>testing in the process, and everybody can see if it
> >>'works' for him or not ...
> >
> >ACK.  A collection of patches that we can all agree
> >on sounds like something worth aiming for.
> >
> >It looks like Kirill last round of patches can form
> >a nucleus for that.  So far I have seem plenty of technical
> >objects but no objections to the general direction.
> yup, I will fix everything and will come with a set of patches for IPC, 
> so we could select which way is better to do it :)
> 
> >So agreement appears possible.
> Nice to hear this!
> 
> Eric, we have a GIT repo on openvz.org already:
> http://git.openvz.org
> 
> we will create a separate branch also called -acked, where patches 
> agreed upon will go.

That's ok by me.  If a more neutral name/site were preferred, we could
use the sf.net set we had finally gotten around to setting up -
www.sf.net/projects/lxc  (LinuX Containers).  Unfortunately that would
likely be just a quilt patch repository.

A wiki + git repository would be ideal.

-serge
