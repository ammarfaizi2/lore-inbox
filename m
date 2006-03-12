Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751577AbWCLRFt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751577AbWCLRFt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 12:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751588AbWCLRFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 12:05:49 -0500
Received: from main.gmane.org ([80.91.229.2]:55277 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751577AbWCLRFs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 12:05:48 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: Problem with a CD
Date: Sun, 12 Mar 2006 17:05:35 +0000
Message-ID: <yw1xd5grbnkw.fsf@agrajag.inprovide.com>
References: <20060312162825.GA16993@platane.lps.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 82.153.166.94
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.15 (linux)
Cancel-Lock: sha1:Gee4Nb7rrSDeDcgzCSAIpzR72vA=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric.Brunet@lps.ens.fr writes:

> Hi all,
>
> In short: I have a CD that windows XP can read but that linux cannot.
>
> I have a mini-CD (with a diameter of 8 cm) that I am trying to read. I
> have tried two computers:

[...]

> I have error messages in my logs:
> on computer #1, they look like:
> |hdc: command error: status=0x51 { DriveReady SeekComplete Error }
> |hdc: command error: error=0x54 { AbortedCommand LastFailedSense=0x05 }
> |ide: failed opcode was: unknown
> |end_request: I/O error, dev hdc, sector 5008
> |Buffer I/O error on device hdc, logical block 1252
> on computer #2, they are simpler:
> |end_request: I/O error, dev sr0, sector 5008
> |Buffer I/O error on device sr0, logical block 1252
>
> On both computers, I have the errors on the same sectors/blocks.
>
> For the two offending files, the errors already occur on the beginings of
> the files.
>
> Of course, all of this point to a defective CD, except that on both
> computers, I can read the files without any problem with windows XP
> (well, actually, I have only read avseq01.dat, which is a video file. I
> haven't tried the other troublesome file.)

Do you have any way of checking whether windows reads the file
correctly, or just fails to detect the error?

-- 
Måns Rullgård
mru@inprovide.com

