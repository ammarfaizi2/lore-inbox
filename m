Return-Path: <linux-kernel-owner+w=401wt.eu-S965377AbXATUcL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965377AbXATUcL (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 15:32:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965369AbXATUcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 15:32:11 -0500
Received: from 1wt.eu ([62.212.114.60]:2097 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965377AbXATUcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 15:32:10 -0500
Date: Sat, 20 Jan 2007 21:31:41 +0100
From: Willy Tarreau <w@1wt.eu>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: Ismail =?iso-8859-1?Q?D=F6nmez?= <ismail@pardus.org.tr>,
       linux-kernel@vger.kernel.org
Subject: Re: Abysmal disk performance, how to debug?
Message-ID: <20070120203140.GE25307@1wt.eu>
References: <200701201920.54620.ismail@pardus.org.tr> <200701201952.54714.ismail@pardus.org.tr> <Pine.LNX.4.63.0701202105210.23674@gockel.physik3.uni-rostock.de> <200701202216.16637.ismail@pardus.org.tr> <20070120201923.GC25307@1wt.eu> <Pine.LNX.4.63.0701202124180.23674@gockel.physik3.uni-rostock.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0701202124180.23674@gockel.physik3.uni-rostock.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 20, 2007 at 09:28:57PM +0100, Tim Schmielau wrote:
> On Sat, 20 Jan 2007, Willy Tarreau wrote:
> 
> > Anyway, in your situation with a very small buffer, this should not 
> > change by more than half a second or so.
> 
> Well, his buffer is not small. He has half a GB of RAM, so when 
> writing 1 GB the buffer would roughly double the dd speed, exactly as he 
> has shown us.

yes, but he sees the opposite : when using half of the memory for the
buffer, he has low speed. When shorting cache size to 2% only, he doubles
his speed.

> Anyways, instead of always just posting similar answers to yours, I'll 
> have dinner now. :-)

:-)
Willy

