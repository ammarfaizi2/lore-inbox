Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280817AbRKLPHb>; Mon, 12 Nov 2001 10:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280816AbRKLPHV>; Mon, 12 Nov 2001 10:07:21 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:21519 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S280813AbRKLPHH>; Mon, 12 Nov 2001 10:07:07 -0500
Message-ID: <3BEFE572.2040908@namesys.com>
Date: Mon, 12 Nov 2001 18:06:26 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010923
X-Accept-Language: en-us
MIME-Version: 1.0
To: arjanv@redhat.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Oops in reiserfs w/2.4.7-10
In-Reply-To: <Pine.LNX.4.33.0111122233530.26293-100000@bad-sports.com> <3BEFBDE0.6080804@namesys.com> <3BEFC301.A92C64D4@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Correction, the NFS rename bug I mentioned is not reiserfs specific, and 
it is fixed by Neil Brown in a patch that is reported to work by our 
users, and it is better described as  a hardlink to unexported files bug 
rather than a rename bug.  So if you apply that patch, or export entire 
filesystems only, it is reasonable to use reiserfs for home directories.

Hans


