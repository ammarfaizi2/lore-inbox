Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbUAEPfn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 10:35:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261731AbUAEPfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 10:35:43 -0500
Received: from intra.cyclades.com ([64.186.161.6]:31462 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S261605AbUAEPfm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 10:35:42 -0500
Date: Mon, 5 Jan 2004 13:26:23 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: mremap bug and 2.4?
In-Reply-To: <20040105145421.GC2247@rdlg.net>
Message-ID: <Pine.LNX.4.58L.0401051323520.1188@logos.cnet>
References: <20040105145421.GC2247@rdlg.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 5 Jan 2004, Robert L. Harris wrote:

>
>
> Just read this on full disclosure:
>
> http://isec.pl/vulnerabilities/isec-0013-mremap.txt
>
> Is it valid?  No working proof of concept code has been posted so I can't
> test my systems.  The article only lists 2.4 and 2.6.  Is this
> 2.4.16-current, etc?  Anyone have any details about versions that are
> safe so I/We can determine if I need to roll a new production kernel out
> again?

It is possible that the problem is exploitable. There is no known public
exploit yet, however.

2.4.24 includes a fix for this (mm/mremap.c diff)
