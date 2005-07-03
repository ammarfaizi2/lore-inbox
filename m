Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261450AbVGCOw5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbVGCOw5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 10:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261452AbVGCOw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 10:52:56 -0400
Received: from trex.wsi.edu.pl ([195.117.114.133]:45015 "EHLO trex.wsi.edu.pl")
	by vger.kernel.org with ESMTP id S261450AbVGCOwt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 10:52:49 -0400
Message-ID: <42C7FBD3.1020002@trex.wsi.edu.pl>
Date: Sun, 03 Jul 2005 16:53:07 +0200
From: =?ISO-8859-2?Q?Micha=B3_Piotrowski?= <piotrowskim@trex.wsi.edu.pl>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       Paul TT <paultt@bilug.linux.it>, randy_dunlap <rdunlap@xenotime.net>,
       Jesper Juhl <jesper.juhl@gmail.com>, cp@absolutedigital.net
Subject: [ANNOUNCE] ORT - Oops Reporting Tool v.b4
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Here is our (see copyright section ;)) simple script that help to create 
a bug report:
http://stud.wsi.edu.pl/~piotrowskim/files/ort/beta/ort-b4.tar.bz2

Why do we do this?
Because many people don't have time to prepare a good (with all 
importrant pieces of information) bug report.

How does it work?
It creates file with information about your system (software, hardware, 
used modules etc.), add file with oops into it and in the future sends 
it to the chosen mainterner or lkml.

How can you help?
If you know something about bash scripting you can review it, add some 
useful features and make some optimalisations. Or just send me an idea.

Changelog:
- Cal Peake (greate thanks for big patch ;)){
    - remove the need to run the (whole) script as root
    - add support for Pine MUA
    - add support for nail MUA
    - add pager selection
    - whitespace cleanup
    - user interface consistency
    - code simplification
    - some other small things
}

Todo before final version:
- more e-mail clients?
- nice ascii logo?

Regards,
Micha³ Piotrowski
