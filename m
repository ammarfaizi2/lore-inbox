Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268315AbTBMVf5>; Thu, 13 Feb 2003 16:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268316AbTBMVf5>; Thu, 13 Feb 2003 16:35:57 -0500
Received: from mailf.telia.com ([194.22.194.25]:50140 "EHLO mailf.telia.com")
	by vger.kernel.org with ESMTP id <S268315AbTBMVf4>;
	Thu, 13 Feb 2003 16:35:56 -0500
X-Original-Recipient: linux-kernel@vger.kernel.org
Message-ID: <004101c2d3a9$3d2c91a0$020120b0@jockeXP>
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Andrew Morton" <akpm@digeo.com>
Cc: <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
References: <1044365707.4067.4.camel@passion.cambridge.redhat.com><IGEFJKJNHJDCBKALBJLLKEDMFKAA.joakim.tjernlund@lumentis.se> <20030213095419.0d71f7d0.akpm@digeo.com>
Subject: Re: [PATCH]  crc32 improvements for 2.5 [RESEND]
Date: Thu, 13 Feb 2003 22:45:34 +0100
Organization: Lumentis AB
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Andrew Morton" <akpm@digeo.com>
> Joakim Tjernlund <joakim.tjernlund@lumentis.se> wrote:
> >
> > I did the optimizations in the crc32 patch Brian Murphy submitted a while ago.
> > Now I have cleaned it up a little and made some more optimizations.
> 
> I added this to -mm, but I don't know how to test it ;)
> 
> What testing have you performed?  And have you any benchmark results?

I have tested this extensivly using JFFS2 on PPC. I belive David Woodhouse 
has done the same on X86.

I don't have any benchmarks, I used the JFFS2 mounting process which
crc32 checks all data and metadata in the FS and timed that.

There are some ethernet drivers that uses crc32 as well.

   Jocke
