Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261482AbTDQOgD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 10:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261501AbTDQOgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 10:36:03 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:45510
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261482AbTDQOgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 10:36:02 -0400
Subject: Re: kernel support for non-English user messages
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: EricAltendorf@orst.edu
Cc: Linus Torvalds <torvalds@transmeta.com>, John Bradford <john@grabjohn.com>,
       vda@port.imtp.ilyichevsk.odessa.ua,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200304141645.48020.EricAltendorf@orst.edu>
References: <Pine.LNX.4.44.0304141024250.19302-100000@home.transmeta.com>
	 <200304141645.48020.EricAltendorf@orst.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050587213.31412.48.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 17 Apr 2003 14:46:54 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-04-15 at 19:02, Eric Altendorf wrote:
> If you find yourself having to write comments and documentation to 
> explain your code, probably your identifiers are not well named, your 
> functions are not short enough, and your code is not well structured 
> enough.
> 
> Ideal code is completely self-documenting.

We have a lot of elegant small functions that require knowledge of
the data structures and lock ordering, which is why I do go around
sticking kernel-doc into stuff I touch. 

Explaining the function is one thing, explaining the context in which
it operates is another [IMHO]

