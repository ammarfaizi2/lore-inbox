Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271890AbTHROti (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 10:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271892AbTHROti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 10:49:38 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:52485 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S271890AbTHROth (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 10:49:37 -0400
Date: Mon, 18 Aug 2003 12:29:33 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Jamie Lokier <jamie@shareable.org>,
       Andries Brouwer <aebr@win.tue.nl>, Neil Brown <neilb@cse.unsw.edu.au>,
       linux-kernel@vger.kernel.org
Subject: Re: Input issues - key down with no key up
Message-ID: <20030818122933.A970@pclin040.win.tue.nl>
References: <20030815135331.GC15872@ucw.cz> <Pine.GSO.3.96.1030816150153.15339E-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1030816150153.15339E-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Sat, Aug 16, 2003 at 03:02:50PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 16, 2003 at 03:02:50PM +0200, Maciej W. Rozycki wrote:

>  Well, mode #3 with no translation in the i8042 looks quite sanely. 

In theory perhaps. In practice it isnt sane at all.

(That is, the majority of the keyboards sold today do not do as one
would wish. Since Microsoft does not require anything for Set 3,
behaviour in Set 3 is essentially random, especially for these
additional keys and buttons. A single keypress may give several
scancodes, or none at all. Many laptops do not have any support
for Set 3. USB compatibility only implements compatibility with
translated Set 2.)

