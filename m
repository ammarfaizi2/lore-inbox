Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266376AbUFQFfK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266376AbUFQFfK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 01:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266377AbUFQFfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 01:35:10 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:1996 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S266376AbUFQFfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 01:35:02 -0400
Message-ID: <40D12DB6.3080606@namesys.com>
Date: Wed, 16 Jun 2004 22:35:50 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Pittman <daniel@rimspace.net>
CC: linux-kernel@vger.kernel.org, Ext3-users@redhat.com
Subject: Re: mode data=journal in ext3. Is it safe to use?
References: <40FB8221D224C44393B0549DDB7A5CE83E31B1@tor.lokal.lan>	<1087322976.1874.36.camel@pla.lokal.lan>	<40D06C0B.7020005@techsource.com> <871xkfroph.fsf@enki.rimspace.net>
In-Reply-To: <871xkfroph.fsf@enki.rimspace.net>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Pittman wrote:

>OTOH, ReiserFS had an extremely long period of instability, 
>
we were stable before ext3 was...

>and was
>build by a group who felt that a working fsck was something you put
>together after you got the filesystem working.
>  
>
Well, if you have a total of two guys working on a filesystem, and 
plenty not working yet in the filesystem, why the hell would you start 
to work on fsck before the main body of code is working and performing 
well enough that anybody would want to use it?  Surely my task ordering 
was correct for a two man team.

With Reiser4 we had funding for an fsck guy, and as a result fsck is 
working at ship.  With V3, we had no funding at all until it started to 
work.

>This, combined with the occasional "ReiserFS 3 ate my data" reports and
>  
>
like ext2/ext3, we are now able to say that almost all such reports are 
hardware (for V3 not V4, V4 gained some bugs when we ported to -mm and 
its radix trees, and is still not shipped as a result).

>the reluctance of the developers to adapt to the 4K kernel stacks in
>2.6.recent,
>
do you use them?  I don't know real users who do, or else I would be 
quicker to care.

On the one hand, you complain about how we were unstable, and on the 
other hand you complain about how we aren't willing to destabilize the 
code to add new features to what is no longer the development branch.  
Seems pretty inconsistent logically to me.
