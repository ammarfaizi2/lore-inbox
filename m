Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751752AbWANLHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751752AbWANLHP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 06:07:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751755AbWANLHO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 06:07:14 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:22761 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751752AbWANLHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 06:07:13 -0500
Subject: Re: [PATCH] Proposed patch for Precise Process Accounting
From: Arjan van de Ven <arjan@infradead.org>
To: Smarduch Mario-CMS063 <CMS063@motorola.com>
Cc: mingo@elte.hu, rml@tech9.net, linux-kernel@vger.kernel.org
In-Reply-To: <2D25C6D9C1440E4E8228FC62AE2864989E7AF7@de01exm69.ds.mot.com>
References: <2D25C6D9C1440E4E8228FC62AE2864989E7AF7@de01exm69.ds.mot.com>
Content-Type: text/plain
Date: Sat, 14 Jan 2006 12:07:03 +0100
Message-Id: <1137236823.3014.11.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-13 at 15:25 -0500, Smarduch Mario-CMS063 wrote:
> Hi Ingo, Robert -
>     I'd like to get input from you and community at large on a patch
> that
> has been in production on 2.4 systems on Debian and Montavista
> distros, and in high risk field environment. Below is a detailed man 
> page of the proposed patch. The patch itself is currently only available


Time measurement in an accurate way is more expensive than 3 years ago,
on PC's at least (eg rdtsc is sort of no longer useful in many cases).
On others it was never cheap. So while this maybe was feasibly 3 years
ago.. today I think the costs are just plain too high.


