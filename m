Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263655AbTDDL00 (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 06:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263646AbTDDL0Z (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 06:26:25 -0500
Received: from mail.hometree.net ([212.34.181.120]:13257 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP id S263641AbTDDLUO (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 06:20:14 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: PATCH: allow percentile size of tmpfs (2.5.66 / 2.4.20-pre2)
Date: Fri, 4 Apr 2003 11:31:41 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <b6jqet$be2$1@tangens.hometree.net>
References: <Pine.LNX.4.44.0304011734370.1503-100000@localhost.localdomain> <ovd6k5l60d.fsf@sap.com> <20030402144432.GB536@zip.com.au> <ovadf8ls8e.fsf@sap.com> <20030402204450.GB17890@wohnheim.fh-wedel.de>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1049455901 11714 212.34.181.4 (4 Apr 2003 11:31:41 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Fri, 4 Apr 2003 11:31:41 +0000 (UTC)
X-Copyright: (C) 1996-2003 Henning Schmiedehausen
X-No-Archive: yes
User-Agent: nn/6.6.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

=?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de> writes:

>On Wed, 2 April 2003 19:33:05 +0200, Christoph Rohland wrote:
>> 
>> No, that's why I said you would need hooks into swapon and
>> swapoff. Then it would adjust on the fly. Else it's useless from the
>> usability point of view. With these hooks it's easy to do.

>Can you show me the easy part with this setup?
>256MB RAM
>512MB swap
>50% tmpfs (384MB)
>fill tmpfs completely
>swapoff -a

# swapoff -a
swapoff: device is busy

# umount /tmpfs
# swapoff -a
#

... in an ideal world, of course.

	Regards
		Henning



-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen          INTERMETA GmbH
hps@intermeta.de        +49 9131 50 654 0   http://www.intermeta.de/

Java, perl, Solaris, Linux, xSP Consulting, Web Services 
freelance consultant -- Jakarta Turbine Development  -- hero for hire
