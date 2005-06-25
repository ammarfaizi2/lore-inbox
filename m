Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261384AbVFZAHk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbVFZAHk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 20:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261288AbVFZAHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 20:07:40 -0400
Received: from trex.wsi.edu.pl ([195.117.114.133]:32222 "EHLO trex.wsi.edu.pl")
	by vger.kernel.org with ESMTP id S261390AbVFZAHf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 20:07:35 -0400
Message-ID: <42BDD5F4.8090801@trex.wsi.edu.pl>
Date: Sun, 26 Jun 2005 00:08:52 +0200
From: =?ISO-8859-2?Q?Micha=B3_Piotrowski?= <piotrowskim@trex.wsi.edu.pl>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Jesper Juhl <jesper.juhl@gmail.com>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       Paul TT <paultt@bilug.linux.it>, randy_dunlap <rdunlap@xenotime.net>
Subject: [ANNOUNCE] ORT - Oops Reporting Tool v.b3
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Here is our (see copyright section ;)) simple script that help to create 
a bug report:
http://stud.wsi.edu.pl/~piotrowskim/files/ort/beta/ort-b3.tar.bz2

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
- point_7_9() (/proc copy) (tar.bz2 is toooo big...)
- point_7_10() (/sys copy)
- point_7_11() (sysctl -A)
- ort_sig() ;)

Regards,
Micha³ Piotrowski
