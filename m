Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261329AbVARPro@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261329AbVARPro (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 10:47:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261333AbVARPqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 10:46:51 -0500
Received: from [217.112.240.26] ([217.112.240.26]:47747 "EHLO mail.tnnet.fi")
	by vger.kernel.org with ESMTP id S261329AbVARPge (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 10:36:34 -0500
Message-ID: <41ED2CF4.C6E4FC0B@users.sourceforge.net>
Date: Tue, 18 Jan 2005 17:36:20 +0200
From: Jari Ruusu <jariruusu@users.sourceforge.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.22aa1r8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: jerome etienne <jme@off.net>
Cc: Fruhwirth Clemens <clemens@endorphin.org>, linux-kernel@vger.kernel.org,
       linux-crypto@nl.linux.org
Subject: Re: Announce loop-AES-v3.0b file/swap crypto package
References: <41EAE36F.35354DDF@users.sourceforge.net>	 <41EB3E7E.7070100@tmr.com> <41EBD4D4.882B94D@users.sourceforge.net>	 <1105989298.14565.36.camel@ghanima>  <20050117212647.GA3754@dantooine> <1106003492.17182.17.camel@ghanima> <41ECDBA9.8030005@off.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jerome etienne wrote:
> 3 years ago i published a paper describing how an attacker would be able
> to modify the content of the encrypted device without being detected.
> http://off.net/~jme/loopdev_vul.html
> 
> i was just curious about the current state of loop-aes. Is it still
> vulnerable to this attack ?

Quote from loop-AES README file
"
Loop device encrypts data but does not authenticate ciphertext. In other
words, it delivers data privacy, but does not guarantee that data has not
been tampered with. Admins setting up encrypted file systems should ensure
that neither ciphertext, nor tools used to access ciphertext (kernel +
kernel modules, mount, losetup, and other utilities) can be trojaned or
tampered.
"

-- 
Jari Ruusu  1024R/3A220F51 5B 4B F9 BB D3 3F 52 E9  DB 1D EB E3 24 0E A9 DD
