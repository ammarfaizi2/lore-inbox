Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313990AbSDQMtw>; Wed, 17 Apr 2002 08:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314003AbSDQMtv>; Wed, 17 Apr 2002 08:49:51 -0400
Received: from ns.suse.de ([213.95.15.193]:275 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S313990AbSDQMtu>;
	Wed, 17 Apr 2002 08:49:50 -0400
Date: Wed, 17 Apr 2002 14:49:45 +0200
From: Dave Jones <davej@suse.de>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5-dj] P4 thermal LVT (damage control)
Message-ID: <20020417144945.H32185@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Zwane Mwaikambo <zwane@linux.realnet.co.sz>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0204171029540.30470-100000@netfinity.realnet.co.sz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2002 at 11:57:40AM +0200, Zwane Mwaikambo wrote:
 > This patch avoids frobbing the LVT if we haven't touched it. In 
 > particular, the case where its handled by SMM. And changes one #ifdef 
 > (Dave does that look ok?)
 > 
 > Against 2.5.8-dj1
 > 
 > <insert "please apply" chanting and bone throwing here>

more icky ifdefs, but I don't think we can do this cleanly any other
way without ripping things apart to something like a bluesmoke-p4.c
and the likes.

applied.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
