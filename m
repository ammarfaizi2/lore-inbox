Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264574AbUASLUX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 06:20:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264575AbUASLUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 06:20:23 -0500
Received: from maximus.kcore.de ([213.133.102.235]:25615 "EHLO
	maximus.kcore.de") by vger.kernel.org with ESMTP id S264574AbUASLUW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 06:20:22 -0500
From: Oliver Feiler <kiza@gmx.net>
To: "Nikita V. Youshchenko" <yoush@cs.msu.su>
Subject: Re: System died because of ide-scsi
Date: Mon, 19 Jan 2004 12:19:25 +0100
User-Agent: KMail/1.5
References: <200401191408.14699@zigzag.lvk.cs.msu.su>
In-Reply-To: <200401191408.14699@zigzag.lvk.cs.msu.su>
Cc: linux-kernel@vger.kernel.org
X-PGP-Key-Fingerprint: E9DD 32F1 FA8A 0945 6A74  07DE 3A98 9F65 561D 4FD2
X-PGP-Key: http://kiza.kcore.de/pgpkey
X-Species: Snow Leopard
X-Operating-System: Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401191219.26379.kiza@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 January 2004 12:08, Nikita V. Youshchenko wrote:
> Hello.
>
> I'm not sure where to report bugs in ide-scsi in kernel 2.4, so trying
> here ...

[...]

> ide-scsi: Strange, packet command initiated yet DRQ isn't asserted
>
> I could log in as root on the console and type several commands (again, up
> to 10 seconds to process a key press). I tried to reset the device using
> hdparm, and that caused kernel oops.

Hm, I reported what looks like a similar problem some time ago. At least the 
symptom, but not what caused it. Though I didn't get an oops.

See my previous mail: 
http://www.ussg.iu.edu/hypermail/linux/kernel/0312.2/0792.html

Also got "ide-scsi: Strange, packet command initiated yet DRQ isn't asserted" 
and afaict this happened the first time since I used 2.4.23. Maybe it is the 
same problem?

If you got an oops you should probably post it. After running through ksymoops 
of course. :)

Bye,
Oliver

-- 
Oliver Feiler  <kiza@(kcore.de|lionking.org|gmx[pro].net)>

