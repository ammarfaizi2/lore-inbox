Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266572AbUFQQyv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266572AbUFQQyv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 12:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266574AbUFQQyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 12:54:51 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:5026 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S266572AbUFQQyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 12:54:49 -0400
Message-ID: <40D1CD0F.4030306@namesys.com>
Date: Thu, 17 Jun 2004 09:55:43 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Daniel Pittman <daniel@rimspace.net>, linux-kernel@vger.kernel.org,
       Ext3-users@redhat.com, Chris Mason <mason@suse.com>
Subject: Re: mode data=journal in ext3. Is it safe to use?
References: <40FB8221D224C44393B0549DDB7A5CE83E31B1@tor.lokal.lan> <1087322976.1874.36.camel@pla.lokal.lan> <40D06C0B.7020005@techsource.com> <871xkfroph.fsf@enki.rimspace.net> <40D12DB6.3080606@namesys.com> <20040617100813.GA19280@redhat.com>
In-Reply-To: <20040617100813.GA19280@redhat.com>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:

>On Wed, Jun 16, 2004 at 10:35:50PM -0700, Hans Reiser wrote:
>
> > >the reluctance of the developers to adapt to the 4K kernel stacks in
> > >2.6.recent,
> > >
> > do you use them?  I don't know real users who do, or else I would be 
> > quicker to care.
>
>The Fedora Core 2 kernel (and what will be RHEL4) is currently
>using 4K stacks.  This makes up quite a large userbase.
>  
>
Sigh.  I guess we have to support it then.

Chris, are you up to doing it?

> > On the one hand, you complain about how we were unstable, and on the 
> > other hand you complain about how we aren't willing to destabilize the 
> > code to add new features to what is no longer the development branch.  
> > Seems pretty inconsistent logically to me.
>
>If you really are reluctant it fix it, there's always the option of
>marking CONFIG_REISER4 as dependant on CONFIG_BROKEN if CONFIG_4KSTACKS
>is selected.
>
>		Dave
>
>
>
>  
>

