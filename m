Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132205AbQKSNl4>; Sun, 19 Nov 2000 08:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131139AbQKSNlr>; Sun, 19 Nov 2000 08:41:47 -0500
Received: from 3dyn88.com21.casema.net ([212.64.94.88]:26642 "HELO
	home.ds9a.nl") by vger.kernel.org with SMTP id <S129904AbQKSNlc>;
	Sun, 19 Nov 2000 08:41:32 -0500
Date: Sun, 19 Nov 2000 14:08:09 +0100
From: Jasper Spaans <jasper@spaans.ds9a.nl>
To: George Garvey <tmwg-linuxknl@inxservices.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What is 2.4.0-test10: md1 has overlapping physical units with md2!
Message-ID: <20001119140809.A21693@spaans.ds9a.nl>
In-Reply-To: <20001119033943.C935@inxservices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001119033943.C935@inxservices.com>; from tmwg-linuxknl@inxservices.com on Sun, Nov 19, 2000 at 03:39:43AM -0800
Organization: http://www.insultant.nl/
X-Copyright: Copyright 2000 C. Jasper Spaans - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 19, 2000 at 03:39:43AM -0800, George Garvey wrote:
> Is this something to be concerned about? It sounds like a disaster waiting
> to happen from the message. This is on 2 systems (with similar disk setups
> [same other than size]).

> Nov 18 16:31:02 mwg kernel: md: serializing resync, md1 has overlapping physical units with md2!  

Nope, nothing to worry about -- it's just a bad choice of wording ;)

What it means is that some partititions in md1 and md2 are on the same disk,
and that the md-code will not do the reconstruction of these arrays in
parallel [of course, for performance reasons].

Regards,
-- 
Jasper Spaans  <jasper@spaans.ds9a.nl>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
