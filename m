Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129501AbRBXIl0>; Sat, 24 Feb 2001 03:41:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129508AbRBXIlQ>; Sat, 24 Feb 2001 03:41:16 -0500
Received: from in.flite.net ([207.203.36.254]:58631 "EHLO in.flite.net")
	by vger.kernel.org with ESMTP id <S129501AbRBXIlE>;
	Sat, 24 Feb 2001 03:41:04 -0500
From: "John E. Adams" <johna@onevista.com>
Reply-To: johna@onevista.com
Organization: One Vista Associates
To: linux-kernel%vger.kernel.org@mail.us-it.net
Subject: Re: reiserfs: still problems with tail conversion
Date: Sat, 24 Feb 2001 03:40:51 -0500
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="us-ascii"
In-Reply-To: <20010223221856.A24959@arthur.ubicom.tudelft.nl> <01022318321302.01755@flash>
In-Reply-To: <01022318321302.01755@flash>
MIME-Version: 1.0
Message-Id: <01022403405100.00992@flash.onevista.com>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 23 February 2001 16:18, Erik Mouw wrote:
> Hi all,
>
> I am running linux-2.4.2-pre4 with Chris Mason's tailconversion bug fix
> applied, but I still have problems with null bytes in files. I wrote a
> little test program that clearly shows the problem:

I tried the test pgm.
First run didn't even hit the disk, so I added O_SYNC to the opens.
No errors were detected.  Then i split out the checking code from the
building code after noticing the checks were run against the buffer cache.
Still no errors.

This is a SuSE 7.0 machine w/512M memory, plenty of disk space and no swap,
running 2.4.2

 johna@onevistacom

