Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280328AbRKNIQb>; Wed, 14 Nov 2001 03:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280339AbRKNIQV>; Wed, 14 Nov 2001 03:16:21 -0500
Received: from mail128.mail.bellsouth.net ([205.152.58.88]:55473 "EHLO
	imf28bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S280328AbRKNIQM>; Wed, 14 Nov 2001 03:16:12 -0500
Message-ID: <3BF22835.FBEA8D66@mandrakesoft.com>
Date: Wed, 14 Nov 2001 03:15:49 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Weinehall <tao@acc.umu.se>
CC: Benjamin LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reformat mtrr.c to conform to CodingStyle
In-Reply-To: <20011112232539.A14409@redhat.com> <20011113121022.L1778@lynx.no> <20011114085714.V17761@khan.acc.umu.se>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Weinehall wrote:
> I don't think Lindent does everything 100% correct; at least its
> formatting of switch/case does look a little fishy:
> 
>         switch (option) {
>         case 1:
>                 /* blaha */
> 
> That feels kind of odd compared to the rest of the codingstyle.
> 
> Comments?!

hehe now we really get into personal preference.

I like the above case statement style, because I see no value in
additional indentation.  The code is presented one level deeper than the
switch statement, which is key.  'case' keywords merely separate the
properly-indented code.  IMHO of course :)

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

