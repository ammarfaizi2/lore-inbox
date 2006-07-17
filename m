Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750888AbWGQW0e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbWGQW0e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 18:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751038AbWGQW0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 18:26:34 -0400
Received: from post-25.mail.nl.demon.net ([194.159.73.195]:35049 "EHLO
	post-25.mail.nl.demon.net") by vger.kernel.org with ESMTP
	id S1750869AbWGQW0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 18:26:33 -0400
Message-ID: <44BC0E8F.2090504@edsons.demon.nl>
Date: Tue, 18 Jul 2006 00:26:23 +0200
From: Rudy Zijlstra <rudy@edsons.demon.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.7.12) Gecko/20050923
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: Jeff Mahoney <jeffm@suse.com>, 7eggert@gmx.de,
       Eric Dumazet <dada1@cosmosbay.com>,
       ReiserFS List <reiserfs-list@namesys.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] reiserfs: fix handling of device names with /'s in them
References: <6xQ4C-6NB-43@gated-at.bofh.it> <6xQea-6ZX-13@gated-at.bofh.it> <E1G1QFx-0001IO-K6@be1.lrz> <44B7D97B.20708@suse.com> <44B9E6D5.2040704@namesys.com> <44BA61A2.5090404@suse.com> <44BA8214.7040005@namesys.com> <44BABB14.6070906@suse.com> <44BAE619.9010307@namesys.com> <44BAECE2.8070301@suse.com> <44BAFDC3.7020301@namesys.com> <44BB0146.7080702@suse.com> <44BB3C42.1060309@namesys.com> <44BBA4CF.8020901@suse.com> <44BBD4B6.5020801@namesys.com> <44BBD942.3080908@suse.com> <44BBDFFC.70601@namesys.com> <44BBEC17.8020507@suse.com> <44BBFB0D.6040105@namesys.com>
In-Reply-To: <44BBFB0D.6040105@namesys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:

>Jeff Mahoney wrote:
>
>  
>
><snip>
>  
>

>so why did you take their stable branch away from them by working on
>more than bugfixes for V3?
>
>Jeff, working on v3 at this point is nuts.  V4 blows it away....
>  
>
Hans,

I appreciate your vision and willingness to work to that vision.

The above though, is pure and simple PR. Please do not confuse PR with 
maintenance, or design maintenance.

I run pretty recent kernels on some of my servers and or workstations 
(2.6.17.4 at the moment). Some others are still using 2.4. All of them 
are using reiserfs3. I use reiser3 for most all, except video 
application partitions where XFS is used. For the past 2 yr i have been 
really pressed for time, and as a result have needed to scale back on 
pet projects, like testing new filesystems which are not yet into 
mainline. Once Reiserfs4 gets into mainline, i will test on a 
workstation. Till that time (and after) any work done on reiserfs3 is 
very much appreciated by me. It is keeping v3 up with changing 
requirements and expectations.

You cannot start developing a new version and then quit supporting the 
previous version. I consider the work Jeff and others have been doing a 
very good maintenance job. YES, a maintenance job. Addition of 
relatively minor features is part of normal maintenance.

I expect you to disagree here, i am used to that (having followed 
reiserfs list for many years).


Cheers,


Rudy Zijlstra

P.S. reducing maintenance to pure bug-fixing is tentamount to announcing 
EOL.
