Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261840AbTEHQR2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 12:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261843AbTEHQR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 12:17:28 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:33159
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261840AbTEHQR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 12:17:26 -0400
Subject: Re: The disappearing sys_call_table export.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jesse Pollard <jesse@cats-chateau.net>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       "viro@parcelfarce.linux.theplanet.co.uk" 
	<viro@parcelfarce.linux.theplanet.co.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Terje Eggestad <terje.eggestad@scali.com>
In-Reply-To: <03050809564900.09057@tabby>
References: <200305081009_MC3-1-37FA-2408@compuserve.com>
	 <03050809564900.09057@tabby>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052407341.10038.69.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 08 May 2003 16:22:22 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> M$ seems to treat everything as a disk file (even "pipes" are implemented
> as temporary files).

So did original Unix, it was a disk file that was anonymous and just
used the direct pointers to blocks for a ring buffer. Storing pipe data
in RAM in the old days was a hideous waste of resources.

> There is NO reason a custom filesystem cannot be layered over other 
> filesystems. It might not be done today (though the references to "userfs"
> keep showing up in such discussions).

Erez Zadoz (not sure of the spelling) did some stacking fs modules on
Linux

> Fix the vulnerability. Then there won't be a virus.

But you don't know if its fixed and if there are any more holes without
being able to detect attackers be they electronic or human.


