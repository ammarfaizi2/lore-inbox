Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315416AbSEUScl>; Tue, 21 May 2002 14:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315417AbSEUSck>; Tue, 21 May 2002 14:32:40 -0400
Received: from asie314yy33z9.bc.hsia.telus.net ([216.232.196.3]:7630 "EHLO
	saurus.asaurus.invalid") by vger.kernel.org with ESMTP
	id <S315416AbSEUSck>; Tue, 21 May 2002 14:32:40 -0400
To: "Calin A. Culianu" <calin@ajvar.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Lazy Newbie Question
In-Reply-To: <fa.lnev59v.el8i1c@ifi.uio.no> <fa.kh0cciv.i5g73p@ifi.uio.no>
From: Kevin Buhr <buhr@telus.net>
Date: 21 May 2002 11:32:38 -0700
Message-ID: <87ptzpwdvd.fsf@saurus.asaurus.invalid>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Calin A. Culianu" <calin@ajvar.org> writes:
> 
> int kcomedilib_main.c: comedi_t * comedi_open(const char *pathname).

Which version of Comedi are you using?  In comedi-0.7.64 (the most
recent that I can find), I see:

  comedi-0.7.64/comedi/kcomedilib/kcomedilib_main.c:
        int comedi_open(unsigned int minor)

In comedilib-0.7.18, I see:

  comedilib-0.7.18/include/comedilib.h:
        comedi_t *comedi_open(const char *fn);

but of course that version is meant to be called from user space.

I can't find the string "pathname" in any Comedi code anywhere.

> 'nuff said.

On the contrary...

-- 
Kevin Buhr <buhr@telus.net>
