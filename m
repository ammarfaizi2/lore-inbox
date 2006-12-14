Return-Path: <linux-kernel-owner+w=401wt.eu-S1751489AbWLNW7i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbWLNW7i (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 17:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751635AbWLNW7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 17:59:38 -0500
Received: from mail.acc.umu.se ([130.239.18.156]:35300 "EHLO mail.acc.umu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751634AbWLNW7h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 17:59:37 -0500
X-Greylist: delayed 1241 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Dec 2006 17:59:37 EST
Date: Thu, 14 Dec 2006 23:38:50 +0100
From: David Weinehall <tao@acc.umu.se>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       jesper.juhl@gmail.com
Subject: Re: [PATCH/RFC] CodingStyle updates
Message-ID: <20061214223850.GC25114@vasa.acc.umu.se>
Mail-Followup-To: Randy Dunlap <randy.dunlap@oracle.com>,
	lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
	jesper.juhl@gmail.com
References: <20061207004838.4d84842c.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061207004838.4d84842c.randy.dunlap@oracle.com>
User-Agent: Mutt/1.4.2.1i
X-Editor: Vi Improved <http://www.vim.org/>
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pub_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2006 at 12:48:38AM -0800, Randy Dunlap wrote:

[snip]

> +but no space after unary operators:
> +		sizeof  ++  --  &  *  +  -  ~  !  defined

Uhm, that doesn't compute...  If you don't put a space after sizeof,
the program won't compile.

int c;
printf("%d", sizeofc);

Options are:

sizeof c
sizeof(c)

or

sizeof (c)

If you take sizeof the type rather than the variable, the options are

sizeof(int)

or

sizeof (int)

[snip]


Regards: David Weinehall
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
