Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316580AbSIIHXb>; Mon, 9 Sep 2002 03:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316582AbSIIHXb>; Mon, 9 Sep 2002 03:23:31 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:44816 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S316580AbSIIHX3>; Mon, 9 Sep 2002 03:23:29 -0400
Message-ID: <3D7C4DE0.2D1C9909@aitel.hist.no>
Date: Mon, 09 Sep 2002 09:29:36 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.33 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: clean before or after dep?
References: <1031490782.26902.4.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44.0209081206590.21724-100000@redshift.mimosa.com> <20020908205011.A1671@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:

> With the 2.5 kernel, if make clean or make mrproper is ever _required_
> I would say you had triggered an error in the kernel build system.
> 
> > - theory: a clean should be done after a failing build so that
> >   a subsequent build won't use the results of the failing build.
> Should not be needed with the build system in the 2.5 kernel.

Make clean is nice to have for a couple of occations:

1. Before making a tar.bz2 of the tree as a backup.  Why 
   waste space on .o files?
   A backup is useful for a number of reasons, such as
   before testing a mix of patches that might
   interferre badly.  Or even patches for another version. 
   Getting the tree again takes time.

2. The pc hardware clock screwed up again and timestamps
   are spread all over past and future :-(  Make clean time.

Helge Hafting
