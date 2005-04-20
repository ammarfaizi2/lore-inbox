Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261817AbVDTVdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261817AbVDTVdj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 17:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbVDTVdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 17:33:38 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:6326 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261817AbVDTVdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 17:33:37 -0400
Date: Wed, 20 Apr 2005 23:33:36 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Phillip Lougher <phillip@lougher.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove some usesless casts
Message-ID: <20050420213336.GA22421@wohnheim.fh-wedel.de>
References: <20050420065500.GA24213@wohnheim.fh-wedel.de> <4266732A.6050508@lougher.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4266732A.6050508@lougher.demon.co.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 April 2005 16:20:10 +0100, Phillip Lougher wrote:
> Jörn Engel wrote:
> >Squashfs is extremely cast-happy.  This patch makes it less so.
> 
> Thanks for the patch.  Unnecessary casts were one of the things 
> mentioned when I submitted the patches to the LKML, and therefore I 
> suspect most of them have been already fixed (but I will apply your 
> patch to check).

Your definition of _unnecessary_ casts may differ from mine.
Basically, every cast is unnecessary, except for maybe one or two - if
that many.

> I will send revised patches to the LKML soon, most of the issues raised 
> by the comments have been fixed, the current delay is being caused by 
> the 4GB limit re-work.

There are three more patches in my queue, which I'll send after first
coffee or so.  After those I'll ignore squashfs for a while (until you
send current code or so).

Jörn

-- 
The story so far:
In the beginning the Universe was created.  This has made a lot
of people very angry and been widely regarded as a bad move.
-- Douglas Adams
