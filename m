Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130721AbRCEWSI>; Mon, 5 Mar 2001 17:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130722AbRCEWR5>; Mon, 5 Mar 2001 17:17:57 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:60127 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S130721AbRCEWRy>; Mon, 5 Mar 2001 17:17:54 -0500
From: Steven Cole <scole@lanl.gov>
Reply-To: scole@lanl.gov
Date: Mon, 5 Mar 2001 15:17:25 -0700
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.2ac12
MIME-Version: 1.0
Message-Id: <01030515172500.01085@spc.esa.lanl.gov>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It appears that with 2.4.2-ac12, we now have more than 2000 
kernel configuration options.

Using the options_linux script which I posted earlier today,
I get the following:

[steven@spc linux]$ sh scripts/options_linux | wc -l
   2008

Compare to 2.2.18:
[root@spc linux-2.2.18]# sh scripts/options_linux | wc -l
   1466

And for vanilla 2.4.2:
[root@spc linux-2.4.2]# sh scripts/options_linux | wc -l
   1928

Steven
