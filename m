Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290020AbSA3QZG>; Wed, 30 Jan 2002 11:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290014AbSA3QYA>; Wed, 30 Jan 2002 11:24:00 -0500
Received: from chakra.spb.cityline.ru ([212.46.192.29]:52491 "EHLO
	chakra.spb.cityline.ru") by vger.kernel.org with ESMTP
	id <S289987AbSA3QWo>; Wed, 30 Jan 2002 11:22:44 -0500
Date: Wed, 30 Jan 2002 19:25:36 +0300
From: Wartan Hachaturow <wart@softhome.net>
To: linux-kernel@vger.kernel.org
Subject: Console driver behaviour?
Message-ID: <20020130162536.GA12421@mojo.spb.ru>
Reply-To: wart@softhome.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

How can I determine that the program is run via ssh or on
a headless box?
The problem is with Linux Console Tools. It tries opening 
/dev/tty, /dev/tty0 and /dev/console respectively upon the 
start, and it fails on ssh'ed or headless boxes. Is there 
any way to catch the situation? I've thought that open should
return ENODEV in these cases, but it doesn't..

-- 
Regards, Wartan.
"Computers are not intelligent. They only think they are."
