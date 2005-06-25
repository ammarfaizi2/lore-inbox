Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261301AbVFYQc1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261301AbVFYQc1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 12:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261314AbVFYQc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 12:32:27 -0400
Received: from trex.wsi.edu.pl ([195.117.114.133]:53442 "EHLO trex.wsi.edu.pl")
	by vger.kernel.org with ESMTP id S261301AbVFYQcX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 12:32:23 -0400
Message-ID: <42BD6B33.6090308@trex.wsi.edu.pl>
Date: Sat, 25 Jun 2005 16:33:23 +0200
From: =?ISO-8859-2?Q?Micha=B3_Piotrowski?= <piotrowskim@trex.wsi.edu.pl>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       Paul TT <paultt@bilug.linux.it>, randy_dunlap <rdunlap@xenotime.net>,
       Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: [ANNOUNCE] ORT - Oops Reporting Tool
References: <42BBE593.9090407@trex.wsi.edu.pl>
In-Reply-To: <42BBE593.9090407@trex.wsi.edu.pl>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Here is our (see copyright section ;)) simple script that help to create 
a bug report:
http://stud.wsi.edu.pl/~piotrowskim/files/ort/beta/ort-b2.tar.bz2

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
- Paul TT {
 - I wrote a yes_no function tho check answer to "[Y/n]" questions
 - I added some extra checks when multiple answer asked, if the reply is 
blank, bash primt out a lot of unary expected errors
 - added detection of PAGER env variable
}
- Paolo Ciarrocchi - kernel-ort-doc.patch

Regards,
Micha³ Piotrowski
