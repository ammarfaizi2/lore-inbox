Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262097AbUK3Oxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262097AbUK3Oxl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 09:53:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262098AbUK3Oxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 09:53:41 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:37801 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262097AbUK3Oxj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 09:53:39 -0500
Message-Id: <200411301451.iAUEptDH006868@laptop11.inf.utfsm.cl>
To: Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk>
cc: Christian Mayrhuber <christian.mayrhuber@gmx.net>,
       reiserfs-list@namesys.com, Hans Reiser <reiser@namesys.com>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: file as a directory 
In-Reply-To: Message from Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk> 
   of "Mon, 29 Nov 2004 22:59:31 -0000." <41ABA9D3.7020602@st-andrews.ac.uk> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Tue, 30 Nov 2004 11:51:55 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk> said:
> Horst von Brand wrote:
> >Now think about files with other formats, for instance the (in)famous
> >sendmail.cf, or less structured stuff like you find in /etc/init.d/, or
> >just Postgres databases (with fun stuff like permissions on records and
> >fields)... or just people groping in /etc/passwd wanting to find the whole
> >entry (not just one field), or perhaps look at the 15th character of the
> >entry for John Doe.

> >This way lies utter madness (what format description should be applied to
> >what file this time around?). Plus shove all this garbage into the kernel?!

> I was suggesting this idea mainly form XML files, where the tags define 
> the parts clearly.

Use a XML parsing library then.

> In addition, I was suggesting that some of the XPath syntax (normally 
> used for within-XML selection) could be extended above the file level 
> into the file system.

Urgh.

> The problems you mention are all related to non-XML file format issues, 

Most (say 99,95%) files aren't XML; and if they are, the requisite parsing
is probably on hand already, so...

> which was only a minor comment in parenthesis in my original mail. I am 
> happy to do it only for XML to begin with (and if possible later see if 
> it can be done for SOME non-XML formats).

Please don't.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
