Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262557AbRFBMmr>; Sat, 2 Jun 2001 08:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262558AbRFBMmh>; Sat, 2 Jun 2001 08:42:37 -0400
Received: from mout0.freenet.de ([194.97.50.131]:30636 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id <S262557AbRFBMm0> convert rfc822-to-8bit;
	Sat, 2 Jun 2001 08:42:26 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Andreas Hartmann <andihartmann@freenet.de>
Organization: Privat
To: Rasmus =?iso-8859-1?q?B=F8g=20Hansen?= <moffe@amagerkollegiet.dk>
Subject: Re: [2.4.5 and all ac-Patches] massive file corruption with reiser or NFS
Date: Sat, 2 Jun 2001 14:41:04 +0200
X-Mailer: KMail [version 1.2]
Cc: Kernel-Mailingliste <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L2.0106021251570.1083-100000@grignard.amagerkollegiet.dk>
In-Reply-To: <Pine.LNX.4.33L2.0106021251570.1083-100000@grignard.amagerkollegiet.dk>
MIME-Version: 1.0
Message-Id: <01060214363800.02172@athlon>
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by susi.maya.org id f52Cf5A08134
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag,  2. Juni 2001 12:52 schrieb Rasmus Bøg Hansen:
> On Sat, 2 Jun 2001, Andreas Hartmann wrote:
> > I got massive file corruptions with the kernels mentioned in the subject.
> > I can reproduce it every time.
>
> You cannot use NFS on reiserfs unless you apply the knfsd patch. Look at
> www.namesys.com.

Thank you very much for your advice.

I tested your suggestion and run the machine without NFS-mounted devices - it 
seems to be working fine. 

Anyway - I'm wondering why I didn't get any problem until 2.4.4ac10 with this 
configuration without the appropriate patch on the client or on the server?

I'm a little bit confused now about this patch.
Do I need this knfsd-patch for the NFS-server or just for the clients or for 
both?


Thank you for your advice,
Andreas Hartmann
