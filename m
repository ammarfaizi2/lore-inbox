Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265832AbTFSQXw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 12:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265834AbTFSQXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 12:23:52 -0400
Received: from [203.149.0.18] ([203.149.0.18]:33239 "EHLO
	krungthong.samart.co.th") by vger.kernel.org with ESMTP
	id S265832AbTFSQXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 12:23:50 -0400
Message-ID: <3EF1E6CD.4040800@thai.com>
Date: Thu, 19 Jun 2003 23:37:33 +0700
From: Samphan Raruenrom <samphan@thai.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Samphan Raruenrom <samphan@thai.com>
Subject: Crusoe's persistent translation on linux?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm using 2.4.21 kernel on TM5800 Crusoe in Compaq TC1000 Tablet PC.
Currently the performance is not very good but the more I learn
about its architecture the more I'm obessesed about it (just like
the days when I use 68000 Amiga). Too bad that there are very little
information about the chip so I can't do anything much to improve
the performance myself (like enlarge the translation cache? how?).

On later versions of CMS (Code Morphing Software), there's a piece
of system software called "Persistent Translation service".
It looks like the purpose of the service is to get the translations
from the translation cache according to each user applications run
during the session and save them as binary files using the same name
with ".SYS.DB" appended, e.g. MOZILLA.EXE.SY.DB, NOTEPAD.EXE.SY.DB

I guess they are the native TM5800 code "essenses (very small part
that really get executed)" of those software. If my linux has the
service, I imagine that after using the system for a week, my system
will be filled by tranlated binaries and the processor will spend more
time with native application code than with the CMS. And no one will ask
for native crusoe compiler anymore. The best compiler is CMS.

Is it possible to have persistent translation on linux?



Regards,
Samphan Rareunrom,
National Electronics and Computer Technology Center,
Thailand.

