Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311029AbSCHTPJ>; Fri, 8 Mar 2002 14:15:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311032AbSCHTO7>; Fri, 8 Mar 2002 14:14:59 -0500
Received: from rover.mkp.net ([209.217.122.9]:54030 "EHLO rover")
	by vger.kernel.org with ESMTP id <S311029AbSCHTOo>;
	Fri, 8 Mar 2002 14:14:44 -0500
To: Svetoslav Slavtchev <galia@st-peter.stw.uni-erlangen.de>
Cc: Stephen Lord <lord@sgi.com>, linux-kernel@vger.kernel.org,
        linux-xfs@oss.sgi.com
Subject: Re: 2.4.18-rc4-aa1 XFS oopses caused by cpio
From: "Martin K. Petersen" <mkp@mkp.net>
Organization: mkp.net
In-Reply-To: <1015580766.20800.3.camel@svetljo.st-peter.stw.uni-erlangen.de>
	<3C88B612.1070206@sgi.com>
	<3C88C9A1.5070502@st-peter.stw.uni-erlangen.de>
	<3C88CB1C.90203@sgi.com>
	<1015613123.4301.11.camel@svetljo.st-peter.stw.uni-erlangen.de>
Date: 08 Mar 2002 14:14:36 -0500
In-Reply-To: <1015613123.4301.11.camel@svetljo.st-peter.stw.uni-erlangen.de>
Message-ID: <yq13czax46b.fsf@austin.mkp.net>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Civil Service)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Svetoslav" == Svetoslav Slavtchev <galia@st-peter.stw.uni-erlangen.de> writes:

Svetoslav> and a stupid question is there a way to limit the I/O
Svetoslav> request that XFS sends to the lower layer ( soft RAID or
Svetoslav> lvm ) without need to modify existing fs just a hack until
Svetoslav> the raid-0 code in 2.5 is fixed

Not really.  Besides, requests may be merged and that would give the
same result.

I've been busy with IA-64 stuff the last week - I'll try to get back
to the RAID hacking this weekend.  I have all of my code merged but
still need to deal with multi-zone setups.

-- 
Martin K. Petersen, Principal Linux Consultant, Linuxcare, Inc.
mkp@linuxcare.com, http://www.linuxcare.com/
SGI XFS for Linux Developer, http://oss.sgi.com/projects/xfs/

