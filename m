Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261687AbVC1EMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261687AbVC1EMN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 23:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261690AbVC1EMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 23:12:13 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:9957 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261687AbVC1EML (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 23:12:11 -0500
Date: Sun, 27 Mar 2005 20:10:54 -0800
From: Paul Jackson <pj@engr.sgi.com>
To: Dave Jones <davej@redhat.com>
Cc: jengelh@linux01.gwdg.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] no need to check for NULL before calling kfree()
 -fs/ext2/
Message-Id: <20050327201054.57eb7791.pj@engr.sgi.com>
In-Reply-To: <20050327174026.GA708@redhat.com>
References: <Pine.LNX.4.62.0503252307010.2498@dragon.hyggekrogen.localhost>
	<Pine.LNX.4.61.0503251726010.6354@chaos.analogic.com>
	<1111825958.6293.28.camel@laptopd505.fenrus.org>
	<Pine.LNX.4.61.0503261811001.9945@chaos.analogic.com>
	<Pine.LNX.4.62.0503270044350.3719@dragon.hyggekrogen.localhost>
	<1111881955.957.11.camel@mindpipe>
	<Pine.LNX.4.62.0503271246420.2443@dragon.hyggekrogen.localhost>
	<20050327065655.6474d5d6.pj@engr.sgi.com>
	<Pine.LNX.4.61.0503271708350.20909@yvahk01.tjqt.qr>
	<20050327174026.GA708@redhat.com>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave writes:
> Am I the only person who is completely fascinated by the
> effort being spent here micro-optimising something thats

Eh .. it's well known behaviour.  Bring two questions before a
committee, one for millions of dollars and the other for pocket change,
and watch the committee spend more time discussing the second question.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
