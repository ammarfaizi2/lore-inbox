Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265087AbUHRIc7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265087AbUHRIc7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 04:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265091AbUHRIc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 04:32:58 -0400
Received: from madrid10.amenworld.com ([62.193.203.32]:2314 "EHLO
	madrid10.amenworld.com") by vger.kernel.org with ESMTP
	id S265087AbUHRIcj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 04:32:39 -0400
Date: Wed, 18 Aug 2004 10:28:51 +0200
From: DervishD <disposable1@telefonica.net>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: setproctitle
Message-ID: <20040818082851.GA32519@DervishD>
Mail-Followup-To: Linux-kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.2.1i
Organization: Pleyades
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi all :)

    Is there any special reason not to implement setproctitle in the
kernel? In user space is a bit difficult to implement since 'argv[0]'
cannot grow beyond the initially allocated space, better said, it can
grow but only changing the pointer to another place or eating the
space occupied by the other arguments.

    proftpd has a not-very-polite set_proc_title that misses the
final NULL, and a couple of other programs out there uses it, too.
Applications should be free to change theirs proc titles to some
pretty if they want, shouldn't they?

    In proc/base.c you can read about 'setproctitle(3)', that is, in
library space (user space), not kernel space, but AFAIK only FreeBSD
has setproctitle :?

    Thanks in advance :)

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://raul.pleyades.net/
