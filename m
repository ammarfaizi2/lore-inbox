Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264307AbUGIG2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264307AbUGIG2i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 02:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264401AbUGIG2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 02:28:38 -0400
Received: from tag.witbe.net ([81.88.96.48]:16858 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S264307AbUGIG2g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 02:28:36 -0400
Message-Id: <200407090628.i696SWX06170@tag.witbe.net>
Reply-To: <rol@as2917.net>
From: "Paul Rolland" <rol@as2917.net>
To: "'Russell King'" <rmk+lkml@arm.linux.org.uk>
Cc: "'Bernd Eckenfels'" <ecki-news2004-05@lina.inka.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Init single and Serial console : How to ?
Date: Fri, 9 Jul 2004 08:28:29 +0200
Organization: AS2917.net
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <20040708084419.A13706@flint.arm.linux.org.uk>
Thread-Index: AcRkv3getmvnUzuuQmKxf4Tcs3+B2QAvkpFg
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
> 
> Yes, since you exited the process which was pretending to be the init
> program.  Basically, whatever program is pretending to be init must
> never exit or be killed off - it's special.
> 
> You probably wanted to do /sbin/reboot -f
> 

Should have turn my tongue in my mouth, and removes my gloves before
touching the keyboard :)

Yes, that's exactly what was happening, and reboot -f is the way to
restart correctly the machine.

Thanks for fixing me, 
Regards,
Paul

