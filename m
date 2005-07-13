Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262681AbVGMPdn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262681AbVGMPdn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 11:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262930AbVGMPdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 11:33:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:53217 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262681AbVGMPdl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 11:33:41 -0400
Message-ID: <42D5340A.7060002@redhat.com>
Date: Wed, 13 Jul 2005 11:32:26 -0400
From: Peter Staubach <staubach@redhat.com>
User-Agent: Mozilla Thunderbird  (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Vlad C." <vladc6@yahoo.com>
CC: Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux On-Demand Network Access (LODNA)
References: <20050712234425.55899.qmail@web54409.mail.yahoo.com>
In-Reply-To: <20050712234425.55899.qmail@web54409.mail.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vlad C. wrote:

>--- Hans Reiser <reiser@namesys.com> wrote:
>  
>
>>Please treat at greater length how your proposal
>>differs from NFS.
>>    
>>
>
>I think NFS is not flexible enough because:
>
>1) NFS requires synchronization of passwd files or
>NIS/LDAP to authenticate users (which themselves
>require root access on both server and client to
>install)
>2) NFS by definition understands only its own network
>protocol.
>3) NFS requires root privileges on the client to
>mount. I'm not aware of a way to let normal users
>mount an NFS partition other than listing it in the
>client's fstab and adding the 'users' option... but
>then changing fstab still requires root access.
>4) Users have to contact their sysadmin every time
>they want to mount a different partition, a different
>subdirectory of the same partition, or if they want to
>change the local mountpoint, all because the partition
>and mountpoint are hard-coded in fstab.
>
>On the other hand, I envision the following:
>

Please keep in mind that these are restrictions of the current NFS
implementation and are not inherent in an NFS solution.

The implied need for flexibility is being addressed by NFSv4 and the
ability to understand multiple versions of protocols and multiple
protocols is already resident in the system.  We could do some work
to make it more transparent if desired, but it already works.

    Thanx...

       ps
