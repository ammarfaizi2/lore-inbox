Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264219AbRFDMU7>; Mon, 4 Jun 2001 08:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264218AbRFDMPx>; Mon, 4 Jun 2001 08:15:53 -0400
Received: from ppp218-136-59-62.rtm.zonnet.nl ([62.59.136.218]:16512 "HELO
	localhost.localdomain") by vger.kernel.org with SMTP
	id <S264214AbRFDMPp>; Mon, 4 Jun 2001 08:15:45 -0400
Date: Mon, 4 Jun 2001 13:53:07 +0200
From: Remi Turk <remi@a2zis.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: symlink_prefix
Message-ID: <20010604135307.A8710@localhost.localdomain>
Mail-Followup-To: Alexander Viro <viro@math.psu.edu>,
	linux-kernel@vger.kernel.org
In-Reply-To: <UTC200106031053.MAA185287.aeb@vlet.cwi.nl> <Pine.GSO.4.21.0106030703590.27673-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0106030703590.27673-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Sun, Jun 03, 2001 at 07:25:25AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 03, 2001 at 07:25:25AM -0400, Alexander Viro wrote:
> BTW, bind and friends are also easy - it's
> 	what = open(old, 0);
> 	where = open(mountpoint, 0);
> 	new_mount(where, MNT_BIND, what);
> 
> Comments?

What if `what' and or `where' aren't directories but e.g. sockets?
(IOW, would this allow binding sockets into the filesystem,
or am I being too perverse here?)

Happy Hacking

-- 
Linux 2.4.5-ac6 #2 Sun Jun 3 15:45:27 CEST 2001
