Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267212AbUI0TEl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267212AbUI0TEl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 15:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267232AbUI0TEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 15:04:41 -0400
Received: from enforcerxii.solutionip.com ([216.83.4.32]:45065 "EHLO
	enforcer.solutionip.com") by vger.kernel.org with ESMTP
	id S267212AbUI0TEj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 15:04:39 -0400
From: James Oakley <joakley@solutioninc.com>
Organization: SolutionInc
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc2-mm4 + alps locks input in X
Date: Mon, 27 Sep 2004 16:04:18 -0300
User-Agent: KMail/1.6.2
References: <20040927192744.GA8947@luna.mooo.com>
In-Reply-To: <20040927192744.GA8947@luna.mooo.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200409271604.33993.joakley@solutioninc.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Monday 27 September 2004 4:27 pm, Micha Feigin wrote:
> I tried both with mm4 with the already included alps patch and with
> bk11 and bk13 with the patch manually applied. In both cases when
> starting X with the alps driver input is completely dead in X, both
> mouse and keyboard, including sysrq keys and num-lock/caps-lock.

I had this problem when I accidentally used the event device for my keyboard 
instead of the touchpad. It didn't help that every alps XF86Config example 
out there points to event1, which is my keyboard.

cat /proc/bus/input/devices to see which event device to use.

- -- 
James Oakley
Engineering - SolutionInc Ltd.
joakley@solutioninc.com
http://www.solutioninc.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBWGQ+4U2uQswGyDcRAh4bAJ93zzNwUXkLr6vLmfq9IR1BomfiEgCgjS5Q
pxHpu3Ev+ltw7Sz3mEBItGw=
=D5Kj
-----END PGP SIGNATURE-----
