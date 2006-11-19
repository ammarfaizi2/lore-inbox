Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932950AbWKSTEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932950AbWKSTEr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 14:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932952AbWKSTEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 14:04:46 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:27630 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S932950AbWKSTEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 14:04:46 -0500
Message-ID: <4560AAC1.3000800@oracle.com>
Date: Sun, 19 Nov 2006 11:04:33 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Jeff Mahoney <jeffm@suse.com>, lkml <linux-kernel@vger.kernel.org>,
       reiserfs-dev@namesys.com, sam@ravnborg.org,
       Al Viro <viro@ftp.linux.org.uk>
Subject: Re: reiserfs NET=n build error
References: <20061118202206.01bdc0e0.randy.dunlap@oracle.com> <200611190650.49282.ak@suse.de> <45608FC2.5040406@suse.com> <200611191959.55969.ak@suse.de>
In-Reply-To: <200611191959.55969.ak@suse.de>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>>> I would copy a relatively simple C implementation, like arch/h8300/lib/checksum.c
>> As long as the h8300 version has the same output as the x86 version.
> 
> The trouble is that the different architecture have different output 
> for csum_partial. So you already got a bug when someone wants to move
> file systems.
> 
> -Andi

That argues for having only one version of it (in a lib.; my preference)
-or- Every module having its own local copy/version of it.  :(

-- 
~Randy
