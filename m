Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292491AbSBPUXt>; Sat, 16 Feb 2002 15:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292492AbSBPUXl>; Sat, 16 Feb 2002 15:23:41 -0500
Received: from ns.suse.de ([213.95.15.193]:35594 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S292491AbSBPUXa>;
	Sat, 16 Feb 2002 15:23:30 -0500
Date: Sat, 16 Feb 2002 21:23:27 +0100
From: Dave Jones <davej@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] shrink struct page for 2.5
Message-ID: <20020216212327.C4777@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
In-Reply-To: <Pine.LNX.4.33L.0202161804330.1930-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33L.0202161804330.1930-100000@imladris.surriel.com>; from riel@conectiva.com.br on Sat, Feb 16, 2002 at 06:15:03PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 16, 2002 at 06:15:03PM -0200, Rik van Riel wrote:
 > Hi,
 > 
 > I've forward-ported a small part of the -rmap patch to 2.5,
 > the shrinkage of the struct page. Most of this code is from
 > William Irwin and Christoph Hellwig.

 Anton Blanchard did some nice benchmarks of this work a while
 ago, and noticed that with one of the features (I think the
 I forget which its in the l-k archives somewhere) there
 seemed to be a noticable performance degradation.
 Of course, this was a dbench test, so how reflective this is
 of real world is another story..

 Maybe Randy Hron can throw it in with the next round of
 kernel tests he does ?

 > Unfortunately I haven't managed to make 2.5.5-pre2 to boot on
 > my machine, so I haven't been able to test this port of the
 > patch to 2.5.

 Just a complete lock up ? oops ? anything ?

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
