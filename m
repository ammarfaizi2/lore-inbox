Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136227AbREGPkK>; Mon, 7 May 2001 11:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136216AbREGPkB>; Mon, 7 May 2001 11:40:01 -0400
Received: from ncc1701.cistron.net ([195.64.68.38]:45842 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S136213AbREGPjy>; Mon, 7 May 2001 11:39:54 -0400
From: "Rob Turk" <r.turk@chello.nl>
Subject: Re: SCSI Tape corruption - update
Date: Mon, 7 May 2001 17:39:03 +0200
Organization: Cistron Internet Services B.V.
Message-ID: <9d6fk8$m7p$1@ncc1701.cistron.net>
In-Reply-To: <Pine.WNT.4.31.0105071638470.346-100000@pc209.sinfopragma.it>
X-Trace: ncc1701.cistron.net 989249992 22777 213.46.44.164 (7 May 2001 15:39:52 GMT)
X-Complaints-To: abuse@cistron.nl
X-Priority: 3
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Lorenzo Marcantonio" <lorenzo.marcantonio@sinfopragma.it> wrote in message
news:cistron.Pine.WNT.4.31.0105071638470.346-100000@pc209.sinfopragma.it...
>
> As of my latest build [2.4.5-pre1] I've STILL got the tape corruption
> problem. Some new facts:
>
> (1) It happens only writing the tape (tried exchanging tapes with a
> brand new Alpha Digital Tru64 box). I can read her tape, she can't read
> my tape. Tried with GNU tar and gzip.
>

Lorenzo,

Have you ruled out hardware failures? There's been a few isolated reports
about tape drives returning good status on write, where in fact they were
writing corrupt data. This can happen when the compression hardware is
malfunctioning. On many tape drives, read-back check isn't carried all the
way back to the original (uncompressed) data.

Rob




