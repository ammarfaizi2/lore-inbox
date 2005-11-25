Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751017AbVKYLxL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbVKYLxL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 06:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbVKYLxL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 06:53:11 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:23558 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1751017AbVKYLxK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 06:53:10 -0500
To: Rob Landley <rob@landley.net>
Cc: Neil Brown <neilb@suse.de>, Al Viro <viro@ftp.linux.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: pivot_root broken in 2.6.15-rc1-mm2
References: <17283.52960.913712.454816@cse.unsw.edu.au>
	<20051123021545.GP27946@ftp.linux.org.uk>
	<17283.56197.347658.787608@cse.unsw.edu.au>
	<200511230602.53960.rob@landley.net>
From: Nix <nix@esperi.org.uk>
X-Emacs: it's not slow --- it's stately.
Date: Fri, 25 Nov 2005 11:52:33 +0000
In-Reply-To: <200511230602.53960.rob@landley.net> (Rob Landley's message of
 "23 Nov 2005 12:03:42 -0000")
Message-ID: <87psopkkqm.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Nov 2005, Rob Landley gibbered uncontrollably:
> Rather than unmounting rootfs, it deletes everything out of it to free up the 
> space.  (It basically does the functional equivalent of "find / -xdev | xargs 
> rm -rf"

Er, find / -xdev | xargs rm -f, I hope.

(rm won't respect the -xdev you gave to find, and, well, if your new root is
mounted at all, you're dead :) )

-- 
`Y'know, London's nice at this time of year. If you like your cities
 freezing cold and full of surly gits.' --- David Damerell

