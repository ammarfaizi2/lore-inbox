Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281267AbRLAAnJ>; Fri, 30 Nov 2001 19:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281252AbRLAAm7>; Fri, 30 Nov 2001 19:42:59 -0500
Received: from web20510.mail.yahoo.com ([216.136.226.145]:54031 "HELO
	web20510.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S283871AbRLAAms>; Fri, 30 Nov 2001 19:42:48 -0500
Message-ID: <20011201004247.90162.qmail@web20510.mail.yahoo.com>
Date: Sat, 1 Dec 2001 01:42:47 +0100 (CET)
From: =?iso-8859-1?q?willy=20tarreau?= <wtarreau@yahoo.fr>
Subject: Re: Did someone try to boot 2.4.16 on a 386 ? [SOLVED]
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again !

Just to say that I finally solved my problem. It came
from a wrong vmlinux.lds that had been modified by a
TUX patch applied to an earlier kernel sharing a hard
link with this one. Although I think an unlink before
a regeneration of this file would have been better,
I'll check around to see if there are other parts
which risk to modify a file on disk without previously
unlink it.

Now 2.4.16 works correctly on this 8MB 386.

Regards,
Willy


___________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
Yahoo! Courrier : http://courrier.yahoo.fr
