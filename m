Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267865AbRGVB6f>; Sat, 21 Jul 2001 21:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267866AbRGVB6Z>; Sat, 21 Jul 2001 21:58:25 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:37896 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S267865AbRGVB6R>;
	Sat, 21 Jul 2001 21:58:17 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Michael S. Miles" <mmiles@alacritech.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: kgdb and/or kdb for RH7.1 
In-Reply-To: Your message of "Sat, 21 Jul 2001 12:30:34 -0400."
             <KIEKJCGPOOADIOGPDJJLOEPGEFAA.mmiles@alacritech.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 22 Jul 2001 11:58:15 +1000
Message-ID: <1632.995767095@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sat, 21 Jul 2001 12:30:34 -0400, 
"Michael S. Miles" <mmiles@alacritech.com> wrote:
>Does anyone know if patches exist against the stock RedHat 7.1
>kernel(2.4.2-2) to support remote kernel debugging(kgdb).  I would also be
>interested in the same for kdb, but I'm primarily interested in kgdb.

ftp://oss.sgi.com/projects/xfs/download/Release-1.0/patches/linux-2.4.2-kdb-04112001.patch.gz
is kdb v1.8 against Redhat 7.1.  There are no XFS dependencies in that
patch, but kdb and xfs hit a couple of common files so you might need
to resolve some patch failures.

It is a lot easier to start from that patch instead of trying to
convert a kdb patch from a standard kernel onto Redhat's kernel.  RH
took patches from the -ac tree as well which really messed up kdb, it
took me several hours to work out whta RH had done to each file, and I
had all the kdb patches.  AFAICR, the IKD patch in RH 7.1 does not fit
correctly.

