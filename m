Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292359AbSBPMlV>; Sat, 16 Feb 2002 07:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292360AbSBPMlM>; Sat, 16 Feb 2002 07:41:12 -0500
Received: from web20511.mail.yahoo.com ([216.136.175.150]:1878 "HELO
	web20511.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S292359AbSBPMlC>; Sat, 16 Feb 2002 07:41:02 -0500
Message-ID: <20020216124101.19088.qmail@web20511.mail.yahoo.com>
Date: Sat, 16 Feb 2002 13:41:01 +0100 (CET)
From: =?iso-8859-1?q?willy=20tarreau?= <wtarreau@yahoo.fr>
Subject: Re: [PATCH]:Ethernet Bonding Driver-2.4.17
To: Rajasekhar Inguva <irajasek@in.ibm.com>, girouard@us.ibm.com
Cc: ctindel@ieee.org, willy@meta-x.org,
        linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3C6E462D.39039598@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the fix, Rajasekhar.

I once encountered the same problem which may not
be unique to bonding though, and fixed it by simply
replacing INT_MAX with 2147483647. Both this method
and yours allows far more interfaces than anyone
would need, but at least your fix is cleaner in that
it guarantees that the parameters will really be
checked and not only rely on insmod.

Chad, I don't remember if I sent you my fix, but
I'd prefer this new one. Could you apply it
and/or send it to davem ?

Regards,
Willy


___________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
Yahoo! Mail : http://fr.mail.yahoo.com
