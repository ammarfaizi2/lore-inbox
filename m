Return-Path: <linux-kernel-owner+w=401wt.eu-S1947628AbWLIBUT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947628AbWLIBUT (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 20:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947630AbWLIBUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 20:20:19 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:46093 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1947628AbWLIBUR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 20:20:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:x-enigmail-version:content-type:content-transfer-encoding;
        b=pWgBEl21yoMUGosxP2iM67n29Uti4x6vNmWR8P5K1yBBrIS9iZmqIHtrghxRo8HxEi467cyQ+lPtjMkGI1pMsOd6OILOlavDeuPJiFpgreNjY/bWWuBZdQ2tS1XllpUXkgIkgZVtnPmD2M8Tl7xIem9hbWDJzp7PpxcG4dg7CWA=
Message-ID: <457A0F4C.9060601@gmail.com>
Date: Sat, 09 Dec 2006 02:19:49 +0059
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>, mingo@redhat.com, neilb@cse.unsw.edu.au,
       linux-raid@vger.kernel.org
Subject: oops on 2.6.19-rc6-mm2: deref of 0x28 at permission+0x7
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I got this oops on 2.6.19-rc6-mm2 when starting the system. It happened only
once -- when echo "raidautorun /dev/md0" | nash --quiet was executed. I don't
know why it happened, after reboot it started OK.

There is no md0, only md1, md2 and md3.

See camera-shots here:
http://www.fi.muni.cz/~xslaby/sklad/dm_oops1.png
http://www.fi.muni.cz/~xslaby/sklad/dm_oops2.png

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
