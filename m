Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263789AbTETPCB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 11:02:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263809AbTETPCB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 11:02:01 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:30388 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S263789AbTETPCA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 11:02:00 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16074.18029.571091.558335@gargle.gargle.HOWL>
Date: Tue, 20 May 2003 17:14:53 +0200
From: mikpe@csd.uu.se
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Brian Gerst <bgerst@didntduck.org>, Sam Ravnborg <sam@ravnborg.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Update fs Makefiles
In-Reply-To: <Pine.LNX.4.44.0305200940130.24017-100000@chaos.physics.uiowa.edu>
References: <3EC952E9.9080201@quark.didntduck.org>
	<Pine.LNX.4.44.0305200940130.24017-100000@chaos.physics.uiowa.edu>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai Germaschewski writes:
 > o Possibly add "-y" support to 2.4 (it's a pretty trivial change)

That's the worst thing you could do for those of us maintaining
2.4/2.5 compatibility in drivers etc.
Having to check "oh I'm in 2.4, let's see if I'm in 2.4.23 or
$VENDOR 2.4.blah because then these random 2.5-like changes occurred"
sucks like h*ll.

It's much better to have 2.4.$x be like 2.4.$y than 2.5.$z.
