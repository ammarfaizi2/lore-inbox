Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264795AbUISWjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264795AbUISWjK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 18:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264881AbUISWjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 18:39:10 -0400
Received: from merkurneu.hrz.uni-giessen.de ([134.176.2.3]:16629 "EHLO
	merkurneu.hrz.uni-giessen.de") by vger.kernel.org with ESMTP
	id S264795AbUISWjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 18:39:01 -0400
Date: Mon, 20 Sep 2004 08:19:38 +1000 (EST)
From: Sergei Haller <Sergei.Haller@math.uni-giessen.de>
X-X-Sender: gc1007@fb07-calculator.math.uni-giessen.de
To: jonathan@jonmasters.org
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: lost memory on a 4GB amd64
In-Reply-To: <35fb2e5904091915007c02c4b8@mail.gmail.com>
Message-Id: <Pine.LNX.4.58.0409200815420.3644@fb07-calculator.math.uni-giessen.de>
References: <Pine.LNX.4.58.0409161445110.1290@magvis2.maths.usyd.edu.au> 
 <200409161528.19409.andrew@walrond.org> 
 <Pine.LNX.4.58.0409170051200.26494@fb07-calculator.math.uni-giessen.de> 
 <200409161619.28742.andrew@walrond.org> 
 <Pine.LNX.4.58.0409170147320.26494@fb07-calculator.math.uni-giessen.de> 
 <Pine.LNX.4.58.0409190007530.31971@fb07-calculator.math.uni-giessen.de> 
 <35fb2e59040919130154966337@mail.gmail.com> 
 <Pine.LNX.4.58.0409200737010.3644@fb07-calculator.math.uni-giessen.de>
 <35fb2e5904091915007c02c4b8@mail.gmail.com>
Organization: University of Giessen * Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-HRZ-JLUG-MailScanner-Information: Passed JLUG virus check
X-HRZ-JLUG-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Sep 2004, Jon Masters (JM) wrote:

JM> On Mon, 20 Sep 2004 07:47:20 +1000 (EST), Sergei Haller 
JM> 
JM> > I guess I should write a simple C-program using malloc or something to
JM> > reproduce the crash in the simplest possible way, shouldn't I?
JM> 
JM> You've answered your own question Sergei. Thing is - you mentioned the
JM> AGP aperature settings in your original post [...]

well, AGP and PCI I mentioned only as "the bad guys stealing the memory"
and as the reason to why I wanted to spilt the main memory in two 2gb 
blocks or in 3gb+1gb, one block being at the normal address range and the 
other at the addresses >4gb

JM> but we have to rule out stuff like X 

I guess, you're right in htis.

JM> Try a simple test case and then see if you can give any other handy
JM> details on your situation.


thanks so far,

        Sergei
-- 
--------------------------------------------------------------------  -?)
         eMail:       Sergei.Haller@math.uni-giessen.de               /\\
-------------------------------------------------------------------- _\_V
Be careful of reading health books, you might die of a misprint.
                -- Mark Twain
