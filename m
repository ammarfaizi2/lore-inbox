Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130232AbRBZO25>; Mon, 26 Feb 2001 09:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130241AbRBZO2y>; Mon, 26 Feb 2001 09:28:54 -0500
Received: from zeus.kernel.org ([209.10.41.242]:53191 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130223AbRBZO2i>;
	Mon, 26 Feb 2001 09:28:38 -0500
Date: Mon, 26 Feb 2001 12:54:57 +0100
From: "Marco d'Itri" <md@Linux.IT>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][CFT] per-process namespaces for Linux
Message-ID: <20010226125457.F1646@wonderland.linux.it>
In-Reply-To: <20010226005103.V18271@almesberger.net> <Pine.GSO.4.21.0102251910070.26808-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <Pine.GSO.4.21.0102251910070.26808-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Sun, Feb 25, 2001 at 07:26:24PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 26, Alexander Viro <viro@math.psu.edu> wrote:

 >There is no way to implement them without credentials' cache. Which needs
 >to be done for many other reasons, but that's a separate patch and
 >separate story. If it's done - no serious penalty involved. However,
 >I doubt that we want a union on / itself. /dev - sure, /bin and /lib -
 >maybe, but /... What for?
What I'd really like to do is remount / somewhere with mount --bind,
mount over it another skeleton file system which hides setuid programs
and some directories and then run a chrooted sshd in the new root.
If I'm not missing something, this would make creation of secure chroot
environments very easy.

 >Tomorrow I'll try to catch Erik and talk with him about that. I'm not sure
 >that I know anyone in Debian Install System Team (oh, boy... somebody sure
Just write to debian-boot@lists.debian.org.

-- 
ciao,
Marco

