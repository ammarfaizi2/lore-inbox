Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269514AbTGUJPZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 05:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269528AbTGUJPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 05:15:25 -0400
Received: from vega.digitel2002.hu ([213.163.0.181]:4779 "HELO lgb.hu")
	by vger.kernel.org with SMTP id S269514AbTGUJPY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 05:15:24 -0400
Date: Mon, 21 Jul 2003 11:30:21 +0200
From: =?iso-8859-2?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test1: buffer layer error at fs/buffer.c:416
Message-ID: <20030721093021.GA16319@vega.digitel2002.hu>
Reply-To: lgb@lgb.hu
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Operating-System: vega Linux 2.6.0-test1 i686
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When trying with 2.6.0-test1 everything seems to be fine. But when
installing huge deb packages (Debian distribution) _AND_ doing eg some huge
copy together, the great amount of disk i/o triggers somewhere a problem. At
least I got messages like:

http://download.lgb.hu/bufferlayererror.txt

buffer layer error at fs/buffer.c:416

I don't want to include here because it's large, but anyone can view the log
at the URL I've just writen here.

Kernel is 2.6.0-test1, all filesystems are ext3.

After this, dpkg couldn't be interrupted even with signal 9, or SAK key
combo. The interesting thing for me, that the process state is "R", and
eats all of my idle CPU time after the problem. Another dpkg can be
started, but thhen they become to the similar state ... Only reboot
helped. If someone needs additional information, please contact me.

bye,

- Gábor (larta'H)
