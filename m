Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129115AbRB1SCH>; Wed, 28 Feb 2001 13:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129116AbRB1SB6>; Wed, 28 Feb 2001 13:01:58 -0500
Received: from penguin.roanoke.edu ([199.111.154.8]:38667 "EHLO
	penguin.roanoke.edu") by vger.kernel.org with ESMTP
	id <S129115AbRB1SBq>; Wed, 28 Feb 2001 13:01:46 -0500
Message-ID: <3A9D3FD0.76E6457B@linuxjedi.org>
Date: Wed, 28 Feb 2001 13:13:36 -0500
From: "David L. Parsley" <parsley@linuxjedi.org>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH][CFT] per-process namespaces for Linux
In-Reply-To: <Pine.GSO.4.21.0102280213000.4827-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> > Evil idea of the day: non-directory (even non-existant) mount points and
> > non-directory mounts. So then "mount --bind /etc/foo /dev/bar" works.
> 
> Try it. It _does_ work.

Yeah, mount --bind is cool, I've been using it on one of my projects
today.  But - maybe I'm just not thinking creatively enough - what are
the advantages of mount --bind versus just symlinking?

Also, I tried mount --bind fileone filetwo, and it fails if filetwo
doesn't exist. ('mount point filetwo doesn't exist').  Is that supposed
to work?  (using mount from latest redhat beta)

BTW, pivot_root is nifty, too. ;-)

regards,
	David

-- 
David L. Parsley
Network Administrator
Roanoke College
