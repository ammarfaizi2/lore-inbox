Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310179AbSCAXdC>; Fri, 1 Mar 2002 18:33:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310181AbSCAXcw>; Fri, 1 Mar 2002 18:32:52 -0500
Received: from ns.suse.de ([213.95.15.193]:28167 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S310179AbSCAXch>;
	Fri, 1 Mar 2002 18:32:37 -0500
Date: Sat, 2 Mar 2002 00:32:36 +0100
From: Dave Jones <davej@suse.de>
To: svetljo <galia@st-peter.stw.uni-erlangen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: troubles with isofs linux-2.5.5-xfs-dj2
Message-ID: <20020302003236.R7662@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	svetljo <galia@st-peter.stw.uni-erlangen.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3C7FF756.806@st-peter.stw.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C7FF756.806@st-peter.stw.uni-erlangen.de>; from galia@st-peter.stw.uni-erlangen.de on Fri, Mar 01, 2002 at 10:49:10PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2002 at 10:49:10PM +0100, svetljo wrote:
 > i'm having strange troubles with isofs in linux-2.5.5-xfs-dj2
 > compiled in i got ' iso9660 filesystem not suported by kernel '
 > i don't get it, what's wrong

 The makefile is horked. Quick fix is to back out the changes
 to fs/isofs/Makefile in the -dj2 patch.  I've something better
 queued (or at least it looks better, I need to play with it a bit)
 for -dj3.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
