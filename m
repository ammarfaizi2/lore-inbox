Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751208AbWGGNV7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbWGGNV7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 09:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbWGGNV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 09:21:59 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:35794 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751208AbWGGNV7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 09:21:59 -0400
Subject: Re: splice/tee bugs?
From: Arjan van de Ven <arjan@infradead.org>
To: Jens Axboe <axboe@suse.de>
Cc: Michael Kerrisk <michael.kerrisk@gmx.net>, mtk-manpages@gmx.net,
       linux-kernel@vger.kernel.org, akpm@osdl.org,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20060707131403.GY4188@suse.de>
References: <20060707070703.165520@gmx.net>
	 <20060707040749.97f8c1fc.akpm@osdl.org> <20060707114235.243260@gmx.net>
	 <20060707120333.GR4188@suse.de> <20060707122850.GU4188@suse.de>
	 <20060707123110.64140@gmx.net> <20060707124105.GW4188@suse.de>
	 <20060707131247.GX4188@suse.de>  <20060707131403.GY4188@suse.de>
Content-Type: text/plain
Date: Fri, 07 Jul 2006 15:21:54 +0200
Message-Id: <1152278514.3111.77.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I cannot see where this could be happening, Ingo is this valid?

maybe the test found a way to exit the kernel previously while holding
the lock ?

that would be highly lethal in any scenario.. lockdep would just be the
messenger here

