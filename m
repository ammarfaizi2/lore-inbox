Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313062AbSDEQlg>; Fri, 5 Apr 2002 11:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313074AbSDEQl0>; Fri, 5 Apr 2002 11:41:26 -0500
Received: from ns.suse.de ([213.95.15.193]:14354 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S313062AbSDEQlJ>;
	Fri, 5 Apr 2002 11:41:09 -0500
Date: Fri, 5 Apr 2002 18:41:03 +0200
From: Dave Jones <davej@suse.de>
To: svetljo <galia@st-peter.stw.uni-erlangen.de>
Cc: linux-kernel@vger.kernel.org, linux-xfs@thebarn.com
Subject: Re: REPOST : linux-2.5.5-xfs-dj1 - 2.5.7-dj2  (raid0_make_request bug)
Message-ID: <20020405184103.F14828@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	svetljo <galia@st-peter.stw.uni-erlangen.de>,
	linux-kernel@vger.kernel.org, linux-xfs@thebarn.com
In-Reply-To: <3CAD8B9D.8070902@st-peter.stw.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2002 at 01:33:49PM +0200, svetljo wrote:
 > i'm having some interesting troubles
 > i have lvm over soft RAID-0 with LV's formated with XFS and JFS
 > i can work with the JFS LV's,
 >    but i can not with the XFS one's, i can not mount them ( no troubles
 > with XFS normal partitions)
 > so i'd like to ask is this problem with XFS or with raid or lvm
 > and is there a way to fix it

IIRC, this was reported a while ago, and it was something to do with
XFS creating too large requests that upset the raid code.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
