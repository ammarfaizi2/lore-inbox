Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276097AbRJaXsd>; Wed, 31 Oct 2001 18:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276118AbRJaXsX>; Wed, 31 Oct 2001 18:48:23 -0500
Received: from pc-62-31-92-167-az.blueyonder.co.uk ([62.31.92.167]:56559 "EHLO
	kushida.jlokier.co.uk") by vger.kernel.org with ESMTP
	id <S276097AbRJaXsQ>; Wed, 31 Oct 2001 18:48:16 -0500
Date: Wed, 31 Oct 2001 23:47:07 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Cort Dougan <cort@fsmlabs.com>
Cc: Craig Milo Rogers <rogers@ISI.EDU>, Larry McVoy <lm@bitmover.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Timur Tabi <ttabi@interactivesi.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [OT] Module Licensing?
Message-ID: <20011031234707.A9542@kushida.jlokier.co.uk>
In-Reply-To: <20011031092228.J1506@work.bitmover.com> <4986.1004558101@ISI.EDU> <20011031144244.R607@ftsoj.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011031144244.R607@ftsoj.fsmlabs.com>; from cort@fsmlabs.com on Wed, Oct 31, 2001 at 02:42:44PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cort Dougan wrote:
> The GPL 2.0 uses language that makes it pretty clear that it was meant to
> describe the source code, not the object module.

The GPL describes _both_ the source and object code forms of the program.

See section 3, "You may copy and distribute the Program (...) in _object
code or executable form_ under the terms of sections 1 and 2 above
provided that you _also do one of the following:_ ..."

The terms to be followed for object code and executable form are given
explicitly in section 3.

> It uses "source code" to refer to what is licensed under the GPL
> several times.

Actually, section 0 defines what is licensed: "This License applies to
any _program_ or other work which contains a notice placed by the
copyright holder saying it may be distributed under the terms of this
General Public License.

If we are picky, you are right that this does not appear to refer to an
object module _if_ the object module doesn't contain the license notice.
(This may perhaps be unfortunate wording in the GPL (IANAL either)).
(Lucky that newer kernel modules _do_ contain a license notice, isn't it?)

But if you take that strict interpretation, you have _no_ right to copy
or distribute the object module anyway, except as granted by the license
on the accompanying source code.

In other words, the GPL doesn't have to "apply" to the object module to
deny you the right to copy it.  You start with no right to copy the
object module _at all_, except as granted by the copyright owners.

-- Jamie
