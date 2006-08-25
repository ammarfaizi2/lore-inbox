Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932387AbWHYKBf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbWHYKBf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 06:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbWHYKBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 06:01:35 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:29897 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751395AbWHYKBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 06:01:34 -0400
Subject: Re: [PATCH 0/4] Compile kernel with -fwhole-program --combine
From: David Woodhouse <dwmw2@infradead.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0608251149560.5613@yvahk01.tjqt.qr>
References: <1156429585.3012.58.camel@pmac.infradead.org>
	 <1156433068.3012.115.camel@pmac.infradead.org>
	 <Pine.LNX.4.61.0608241840440.16422@yvahk01.tjqt.qr>
	 <1156439110.3012.147.camel@pmac.infradead.org>
	 <Pine.LNX.4.61.0608250759190.7912@yvahk01.tjqt.qr>
	 <1156496116.2984.14.camel@pmac.infradead.org>
	 <Pine.LNX.4.61.0608251110060.1212@yvahk01.tjqt.qr>
	 <1156499122.2984.36.camel@pmac.infradead.org>
	 <Pine.LNX.4.61.0608251149560.5613@yvahk01.tjqt.qr>
Content-Type: text/plain
Date: Fri, 25 Aug 2006 11:01:11 +0100
Message-Id: <1156500071.2984.55.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-25 at 11:51 +0200, Jan Engelhardt wrote:
> Although I cannot give you any logical reasons, there are possibly reasons 
> why building some things manually might help. Oh well, I think in that case 
> I just pass a make option CONFIG_NOCOMBINE, as you said. 

Of course. Sometimes when I'm debugging I make stuff manually with
EXTRA_CFLAGS='-O1 -g', and sometimes I'll probably want do the build
with CONFIG_COMBINED_COMPILE= as well.

That should certainly be possible -- and it _is_ possible with my
makefile hack but mostly by chance. It's a feature which we should
probably try to keep though.

-- 
dwmw2

