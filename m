Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264230AbTDPLFG (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 07:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264292AbTDPLFG 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 07:05:06 -0400
Received: from mail.hometree.net ([212.34.181.120]:21187 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP id S264230AbTDPLFF 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 07:05:05 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: [2.4.21-pre7-ac1] IDE Warning when booting
Date: Wed, 16 Apr 2003 11:16:57 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <b7je39$cfp$1@tangens.hometree.net>
References: <b7jahc$8f0$1@tangens.hometree.net> <20030416103105.GC7135@miggy.org>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1050491817 12793 212.34.181.4 (16 Apr 2003 11:16:57 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Wed, 16 Apr 2003 11:16:57 +0000 (UTC)
X-Copyright: (C) 1996-2003 Henning Schmiedehausen
X-No-Archive: yes
User-Agent: nn/6.6.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Athanasius <link@gurus.tf> writes:


>--ALfTUftag+2gvp1h
>Content-Type: text/plain; charset=us-ascii
>Content-Disposition: inline
>Content-Transfer-Encoding: quoted-printable

>On Wed, Apr 16, 2003 at 10:16:12AM +0000, Henning P. Schmiedehausen wrote:
>> !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
>> vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
>> hda: task_no_data_intr: status=3D0x51 { DriveReady SeekComplete Error }
>> hda: task_no_data_intr: error=3D0x04 { DriveStatusError }
>> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

>   Not the exact, byte-for-byte, same, but, from Configure.help:

Alan did post an explanation for these (which I haven't read before
posting this) that these are harmless. And yes, the task_no_data_intr
vs. set_multmode makes all the difference. :-) Getting these quieted
down would be nice, though.

	Regards
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen          INTERMETA GmbH
hps@intermeta.de        +49 9131 50 654 0   http://www.intermeta.de/

Java, perl, Solaris, Linux, xSP Consulting, Web Services 
freelance consultant -- Jakarta Turbine Development  -- hero for hire
