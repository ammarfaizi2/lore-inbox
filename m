Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262280AbUKKQb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262280AbUKKQb0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 11:31:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262279AbUKKQb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 11:31:26 -0500
Received: from main.gmane.org ([80.91.229.2]:18910 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262280AbUKKQbV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 11:31:21 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Alexander Fieroch <Fieroch@web.de>
Subject: SNES gamepad doesn't work with kernel 2.6.x
Date: Thu, 11 Nov 2004 17:31:08 +0100
Message-ID: <cn044e$nnk$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: osten.wh.uni-dortmund.de
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: de-de, en-us, en
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

I'm using a SNES gamepad at my parallel port. With kernel 2.4.x it
works, but with kernel 2.6.x I get following error while inserting the
module:

# modprobe gamecon gc=0,1,0,0,0,0
FATAL: Error inserting gamecon
(/lib/modules/2.6.9/kernel/drivers/input/joystick/gamecon.ko): No such
device

# modprobe gamecon gamecon.map=0,1,0,0,0,0
FATAL: Error inserting gamecon
(/lib/modules/2.6.9/kernel/drivers/input/joystick/gamecon.ko): No such
device


The module lp is not loaded while parport is.
With kernel 2.4.x there are no problems - so is it a bug?

Thanks in advance,
Alexander
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBk5PLlLqZutoTiOMRAu+IAJ9wzegM5+BB7prIRZi626qqHAsVnQCeK/G/
7LhnIybXM/ogsY5AqC3kMQc=
=BiN9
-----END PGP SIGNATURE-----

