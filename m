Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261979AbTJDKif (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 06:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261982AbTJDKif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 06:38:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:29644 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261979AbTJDKif (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 06:38:35 -0400
X-Authenticated: #1033915
Message-ID: <3F7E9E27.20500@GMX.li>
Date: Sat, 04 Oct 2003 12:17:11 +0200
From: Jan Schubert <Jan.Schubert@GMX.li>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, dz@debian.org
Subject: 2.6.0_test6: CONFIG_I8K produces wrong/no keycodes for special buttons
X-Enigmail-Version: 0.76.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are 4 special buttons on dell-laptops which you could only get to 
work using CONFIG_I8K. This worked well in any 2.4-kernel, by pressing 
these buttons the keycodes 129. 130, 131, 132 get produced. In 
2.6.0-test6_mm2 it produces <nothing>, 162, <nothing>, 110. I've digged 
into the code without any succes for now. Any hints?

Thx,
Jan

PS: Beside that i've also problems to get some of my pcmcia-cards runnig 
(ISDN and WLAN). May someone point me to any URL getting more 
information concerning the new ISDN-TTY-Interface in kernel-2.6?

