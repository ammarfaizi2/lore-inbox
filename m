Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272720AbRINRgP>; Fri, 14 Sep 2001 13:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272727AbRINRgG>; Fri, 14 Sep 2001 13:36:06 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:44413 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S272720AbRINRfs>;
	Fri, 14 Sep 2001 13:35:48 -0400
Message-ID: <20010914193628.A27889@win.tue.nl>
Date: Fri, 14 Sep 2001 19:36:28 +0200
From: Guest section DW <dwguest@win.tue.nl>
To: Lukas Ruf <ruf@tik.ee.ethz.ch>,
        Linux Kernel ml <linux-kernel@vger.kernel.org>
Subject: Re: man pages: howto create a man page ?
In-Reply-To: <20010914161004.C8351@tik.ee.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20010914161004.C8351@tik.ee.ethz.ch>; from Lukas Ruf on Fri, Sep 14, 2001 at 04:10:04PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2001 at 04:10:04PM +0200, Lukas Ruf wrote:

> can anyone give me a hint what the easiest way could be to create a man
> page out of some text?  Is there a latex to man page converter around?
> Is it required that I must learn SGML?

Old-fashioned man pages are written in *roff.
For example,

.TH example 0 2001-09-14 "" ""
.SH NAME
example \- how to write a man page
.SH SYNOPSIS
how to invoke
.SH DESCRIPTION
what it does
.SH "RETURN VALUE"
what it returns
.SH "CONFORMING TO"
standards
.SH NOTES
interesting tidbits
.SH "SEE ALSO"
related stuff

In man(7) you can read about the macros used.
The easiest way to start is to copy some other man page.

These days it is frowned upon if you really use detailed knowledge
of *roff. Man pages are produced by conversion from other formats,
and conversely other formats are produced by conversion from *roff
(e.g., by man2html). Knowing more about *roff than what is documented
in man(7) may be bad for you - these automatic converters have only
a limited knowledge.

