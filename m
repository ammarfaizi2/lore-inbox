Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316047AbSHBPxb>; Fri, 2 Aug 2002 11:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316135AbSHBPxa>; Fri, 2 Aug 2002 11:53:30 -0400
Received: from ns.suse.de ([213.95.15.193]:35602 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S316047AbSHBPwk>;
	Fri, 2 Aug 2002 11:52:40 -0400
Date: Fri, 2 Aug 2002 17:56:09 +0200
From: Dave Jones <davej@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: davidm@hpl.hp.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org, davidm@napali.hpl.hp.com
Subject: Re: adjust prefetch in free_one_pgd()
Message-ID: <20020802175608.O25761@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linus Torvalds <torvalds@transmeta.com>, davidm@hpl.hp.com,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
	davidm@napali.hpl.hp.com
References: <15690.42924.410428.28956@napali.hpl.hp.com> <Pine.LNX.4.44.0208020844000.18265-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0208020844000.18265-100000@home.transmeta.com>; from torvalds@transmeta.com on Fri, Aug 02, 2002 at 08:46:38AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2002 at 08:46:38AM -0700, Linus Torvalds wrote:

 > Personally, I would just say that we should disable prefetch on such
 > clearly broken hardware, but since it's Alans favourite machine (some
 > early AMD Athlon if I remember correctly), I think Alan will disagree ;)

I think I now understand why you silently dropped the 'disable broken hw
prefetch on early stepping P4' patch I sent you. 8-)

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
