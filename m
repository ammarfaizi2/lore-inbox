Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266975AbSKRWlc>; Mon, 18 Nov 2002 17:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266971AbSKRWlc>; Mon, 18 Nov 2002 17:41:32 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:43204 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266959AbSKRWla>;
	Mon, 18 Nov 2002 17:41:30 -0500
Subject: Re: Bugzilla bug tracking database for 2.5 now available.
To: "Khoa Huynh" <khoa@us.ibm.com>
Cc: ak@suse.de, "David S. Miller" <davem@redhat.com>,
       Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       linux-kernel-owner@vger.kernel.org,
       "Martin J. Bligh" <mbligh@aracnet.com>
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFB0E4619F.CE89C5C3-ON85256C75.007BAE8D@pok.ibm.com>
From: "Khoa Huynh" <khoa@us.ibm.com>
Date: Mon, 18 Nov 2002 16:47:47 -0600
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 5.0.11 +SPRs MIAS5EXFG4, MIAS5AUFPV
 and DHAG4Y6R7W, MATTEST |November 8th, 2002) at 11/18/2002 05:47:48 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jeff Garzik wrote:
>> >The bugs assigned to me are all in the 'open' state, with no
>> >obvious way to change them to 'assigned'.
>>
>>
>> There's a radio button just below the additional comments box,
>> "Accept bug (change status to ASSIGNED)". Then hit Commit.
>
>
>That would be the obvious way, but that option is not presented to me :)
>Look at http://gtf.org/garzik/misc/Screenshot.png  ;-)
>

We found out the root cause of this problem.  There are different levels
of privilege in bugzilla, and the bug owners (like Jeff Garzik) have
the privilege to move bugs among different states (like RESOLVED or
CLOSED), but *not* ASSIGNED state.  The original intent of Bugzilla
is that bug owners only work on bugs assigned to them, and the
screening (assigning) bugs is the responsibility of screeners.  I think
this does not apply to kernel bugzilla very well, so we will give bug
owners enough "power" to assign bugs to themselves as well.  Jon has
already given Jeff this power; more will come later (this is a manual
process, sigh :-))

Khoa


