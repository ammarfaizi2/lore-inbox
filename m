Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267867AbUBRTZB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 14:25:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267908AbUBRTZB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 14:25:01 -0500
Received: from pileup.ihatent.com ([217.13.24.22]:58851 "EHLO
	pileup.ihatent.com") by vger.kernel.org with ESMTP id S267867AbUBRTYK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 14:24:10 -0500
To: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Cc: Zoltan NAGY <nagyz@nefty.hu>, linux-kernel@vger.kernel.org
Subject: Re: v2.6 in vmware?
References: <10ADD433537@vcnet.vc.cvut.cz>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 18 Feb 2004 20:23:34 +0100
In-Reply-To: <10ADD433537@vcnet.vc.cvut.cz>
Message-ID: <8765e4fayx.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Petr Vandrovec" <VANDROVE@vc.cvut.cz> writes:

> On 18 Feb 04 at 14:37, Zoltan NAGY wrote:
> > I've been trying to get 2.6.x working in vmware4, but it drops some
> > oopses during init... I cannot provide details, but I'm sure that it
> > does not just me who are having problems with it..
> 
> Definitely you are... I do not know about any problems with running
> 2.6.x as a guest under VMware. 
> 

There was something about sysenter support or something in that
general direction; I had Zwane Mwaikambo send me a patch that worked
around this for pre 4.0.5 vmware, but never got around to test it as I
upgraded the vmware software.

Grep the archives for "[PATCH][2.5] VMWare doesn't like sysenter" and
"2.6.0 under vmware ?", and look here:
http://www.ussg.iu.edu/hypermail/linux/kernel/0401.0/1254.html

mvh,
A

-- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
