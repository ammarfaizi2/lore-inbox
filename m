Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131413AbQLGXUe>; Thu, 7 Dec 2000 18:20:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131414AbQLGXUY>; Thu, 7 Dec 2000 18:20:24 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:22034 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S131413AbQLGXUP>;
	Thu, 7 Dec 2000 18:20:15 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Florian Schmitt <florian@galois.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: oops in 2.4.0test12-pre5+reiserfs+crypto 
In-Reply-To: Your message of "Thu, 07 Dec 2000 23:36:23 BST."
             <00120723362300.00357@phoenix> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 08 Dec 2000 09:49:43 +1100
Message-ID: <5553.976229383@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2000 23:36:23 +0100, 
Florian Schmitt <florian@galois.de> wrote:
>I had the following oops while doing a "find -name" and playing mp3s on 
>my SB live:
>0010:[ne2k-pci:__insmod_ne2k-pci_O/lib/modules/2.4.0-test12/kernel/drivers+-2386971/96]
>It seems strange that the oops occured in ne2k-pci, since no network was 
>connected at that time.

No it did not.  This is the broken klogd oops converter making a mess
of the report.  Always run with "klogd -x" and run ksymoops manually.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
