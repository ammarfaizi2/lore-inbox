Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262479AbVAPLHS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262479AbVAPLHS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 06:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262480AbVAPLHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 06:07:18 -0500
Received: from mproxy.gmail.com ([216.239.56.246]:42928 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262479AbVAPLHO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 06:07:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Swk34p7kKY58XM0R5gkwu9PvU4E8utnzdjey1CTJJ8EXqIKe2Yg+0fv6ZuBgNlSkb0TODTHjZJwQOI7UfiFpqrXD/QEoqYTq2mxvGDAk5JPD/f/RqWy6Q55HV4yyofPWIiz6APi7jFD9Aso+MyOc/7rXURJf7Y/VxfUdzBUiWF8=
Message-ID: <21d7e99705011603072d26727a@mail.gmail.com>
Date: Sun, 16 Jan 2005 22:07:13 +1100
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: 2.6.10 dies when X tries to initialize PCI radeon 9200 SE
Cc: Helge Hafting <helgehaf@aitel.hist.no>, covici@ccs.covici.com,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <9e4733910501160304642f7882@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41E64DAB.1010808@hist.no>
	 <16870.21720.866418.326325@ccs.covici.com>
	 <21d7e997050113130659da39c9@mail.gmail.com>
	 <20050115185712.GA17372@hh.idb.hist.no>
	 <21d7e997050116020859687c4a@mail.gmail.com>
	 <20050116105011.GA5882@hh.idb.hist.no>
	 <9e4733910501160304642f7882@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> you need to check the output from "modprobe drm debug=1" "modprobe
> radeon" and see if drm is misidentifying the board as AGP. We don't
> want to fix something if it isn't broken.


have a look at bug 255 in fd.o bugzilla, this was what was wrong with
the original code, I'd seriously think about putting this code into
the radeon drm not the old stuff..

Dave.
