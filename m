Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262357AbTJNTzo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 15:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262677AbTJNTzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 15:55:44 -0400
Received: from GOL139579-1.gw.connect.com.au ([203.63.118.157]:54926 "EHLO
	goldweb.com.au") by vger.kernel.org with ESMTP id S262357AbTJNTzn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 15:55:43 -0400
Date: Wed, 15 Oct 2003 05:55:36 +1000 (EST)
From: Michael Still <mikal@stillhq.com>
To: =?iso-8859-2?Q?Karel_Kulhav=FD?= <clock@twibright.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: make htmldocs
In-Reply-To: <20031014164124.A2600@beton.cybernet.src>
Message-ID: <Pine.LNX.4.44.0310150551180.16081-100000@diskbox.stillhq.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Oct 2003, [iso-8859-2] Karel Kulhavý wrote:

> I suggest considering replacing the DocBook bloatware for something
> more sane in the kernel tree. You could maybe generate the html
> docs yourself and simply put them somewhere into the Documentation/
> directory into the kernel sources. Or at least on the web, but then
> the people offline couldn't even read the instruction manual for their
> kernel.

It's not the instruction manual. It's kernel API documentation, for the 
kernel code, used by kernel developers.

Then again, I'm happy to be wrong on this. I suggest you develop and 
submit a patch to address your concerns. The patch should probably take 
account of:

 - the existing formatted documentation comments
 - the existing code to turn those comments into docbook 
(scripts/kernel-doc)
 - the existing man page generation scripts (scripts/makeman 
scripts/split-man)
 - the difficulty of keeping separate HTML documentation in sync with the 
code
 - the fact that docbook is the accepted standard for open source 
documentation (including the ldp)

I look forward to reading your patch.

Cheers,
Mikal

-- 

Michael Still (mikal@stillhq.com) | "All my life I've had one dream,
http://www.stillhq.com            |  to achieve my many goals"
UTC + 10                          |    -- Homer Simpson

