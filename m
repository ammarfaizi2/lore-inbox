Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263385AbTDCNpB>; Thu, 3 Apr 2003 08:45:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263389AbTDCNpB>; Thu, 3 Apr 2003 08:45:01 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:11757 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id <S263385AbTDCNpA>;
	Thu, 3 Apr 2003 08:45:00 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Sven Luther <luther@dpt-info.u-strasbg.fr>
Date: Thu, 3 Apr 2003 15:55:48 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [Linux-fbdev-devel] [PATCH]: EDID parser
Cc: James Simmons <jsimmons@infradead.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <4E5C514B42@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  3 Apr 03 at 15:48, Sven Luther wrote:
> 
> Ideally, the EDID reading would be done just after the user request an
> output mapping change for the first time, and then stored privately to
> each output. mode changes and such would be done after the output has
> been assigned only, and you would have the EDID by then. You could even
> reread it regularly, in case the monitor is hot swapped or something such.

Read is not enough. If you have connected one /dev/fbx to two monitors,
you must find highest common denominator for them, and use this one.
                                                                Petr
                                                                

