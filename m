Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319553AbSH3LtY>; Fri, 30 Aug 2002 07:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319560AbSH3LtY>; Fri, 30 Aug 2002 07:49:24 -0400
Received: from ns.suse.de ([213.95.15.193]:2569 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S319553AbSH3LtY>;
	Fri, 30 Aug 2002 07:49:24 -0400
Date: Fri, 30 Aug 2002 13:53:47 +0200
From: Dave Jones <davej@suse.de>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: "Pering, Trevor" <trevor.pering@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.5.32] CPU frequency and voltage scaling (0/4)
Message-ID: <20020830135347.A26909@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Helge Hafting <helgehaf@aitel.hist.no>,
	"Pering, Trevor" <trevor.pering@intel.com>,
	linux-kernel@vger.kernel.org
References: <C81D8E612E5DD6119653009027AE9D3EE091D0@FMSMSX36> <3D6F2704.A78F0A0@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3D6F2704.A78F0A0@aitel.hist.no>; from helgehaf@aitel.hist.no on Fri, Aug 30, 2002 at 10:04:20AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2002 at 10:04:20AM +0200, Helge Hafting wrote:
 > An MHz carries more meaning - it is a measurable frequency.

It's equally meaningless (in fact, less meaningful).
- By your definition my 900MHz VIA C3 is faster than my 800MHz Athlon.
  (Clue: It isn't).
- With trickery like AMD's quantispeed ratings, MHz really is a totally
  meaningless number when relating to performance of a CPU.
- A MHz rating is only meaningful across the same vendor/family of CPUs.

Getting cpufreq's policy interface into something CPU agnostic therefore
precludes MHz ratings AFAICS.

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
