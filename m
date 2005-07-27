Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262347AbVG0B2s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262347AbVG0B2s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 21:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262332AbVG0B2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 21:28:48 -0400
Received: from dsl017-059-136.wdc2.dsl.speakeasy.net ([69.17.59.136]:39826
	"EHLO luther.kurtwerks.com") by vger.kernel.org with ESMTP
	id S262347AbVG0B1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 21:27:55 -0400
Date: Tue, 26 Jul 2005 21:28:53 -0400
From: Kurt Wall <kwall@kurtwerks.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Question re the dot releases such as 2.6.12.3
Message-ID: <20050727012853.GA2354@kurtwerks.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200507251020.08894.gene.heskett@verizon.net> <42E51593.7070902@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42E51593.7070902@didntduck.org>
User-Agent: Mutt/1.4.2.1i
X-Operating-System: Linux 2.6.12.2
X-Woot: Woot!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2005 at 12:38:43PM -0400, Brian Gerst took 21 lines to write:
> Gene Heskett wrote:
> >Greetings;
> >
> >I just built what I thought was 2.6.12.3, but my script got a tummy 
> >ache because I didn't check the Makefile's EXTRA_VERSION, which was 
> >set to .2 in the .2 patch.  Now my 2.6.12 modules will need a refresh 
> >build. :(
> >
> >So whats the proper patching sequence to build a 2.6.12.3?
> >
> 
> The dot-release patches are not incremental.  You apply each one to the 
> base 2.6.12 tree.

This bit me a while back, too. I'll submit a patch to the top-level
README to spell it out.

Kurt
-- 
You cannot propel yourself forward by patting yourself on the back.
