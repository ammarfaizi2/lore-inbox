Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274241AbRIXX1S>; Mon, 24 Sep 2001 19:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274248AbRIXX1I>; Mon, 24 Sep 2001 19:27:08 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:6926 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S274241AbRIXX04>; Mon, 24 Sep 2001 19:26:56 -0400
Subject: Re: Tainting kernels for non-GPL or forced modules
To: ttabi@interactivesi.com (Timur Tabi)
Date: Tue, 25 Sep 2001 00:31:23 +0100 (BST)
Cc: kaos@ocs.com.au (Keith Owens), linux-kernel@vger.kernel.org
In-Reply-To: <3BAF74B8.6070102@interactivesi.com> from "Timur Tabi" at Sep 24, 2001 01:00:24 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15lfC7-00045i-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The reason I ask is because I'm working on a closed-source (unfortunately) 
> driver for Linux, and I'd really like to make it behave as well as possible.

Add a

MODULE_LICENSE("(c) copyright foo, readers will be mangled with the DMCA")

or appropriate tag to it.

That tag is read by modutils (and ignored by older ones) and tells it the
code is non free. 

Nvidia asked about the MODULE_LICENSE tag code being GPL so to make them 
happy I also released it as below to avoid any confusion

Alan

--

Alan Cox hereby grants all parties the right to use and distribute his
MODULE_LICENSE() macro in both source and binary forms, for the purpose of 
identifying the license on software 

Subject to the follow conditions:

 *	The name of the author may not be used to endorse or promote
 *	products derived from this software without specific prior
 *	written permission.

                            NO WARRANTY

BECAUSE THE PROGRAM IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
FOR THE PROGRAM, TO THE EXTENT PERMITTED BY APPLICABLE LAW.  EXCEPT WHEN
OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
PROVIDE THE PROGRAM "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED
OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.  THE ENTIRE RISK AS
TO THE QUALITY AND PERFORMANCE OF THE PROGRAM IS WITH YOU.  SHOULD THE
PROGRAM PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL NECESSARY SERVICING,
REPAIR OR CORRECTION.

IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
REDISTRIBUTE THE PROGRAM AS PERMITTED ABOVE, BE LIABLE TO YOU FOR DAMAGES,
INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL OR CONSEQUENTIAL DAMAGES ARISING
OUT OF THE USE OR INABILITY TO USE THE PROGRAM (INCLUDING BUT NOT LIMITED
TO LOSS OF DATA OR DATA BEING RENDERED INACCURATE OR LOSSES SUSTAINED BY
YOU OR THIRD PARTIES OR A FAILURE OF THE PROGRAM TO OPERATE WITH ANY OTHER
PROGRAMS), EVEN IF SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE
POSSIBILITY OF SUCH DAMAGES.

