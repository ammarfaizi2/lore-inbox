Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262399AbVBBOXO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262399AbVBBOXO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 09:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262539AbVBBOXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 09:23:14 -0500
Received: from main.gmane.org ([80.91.229.2]:12427 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262441AbVBBOXH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 09:23:07 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Richard Hughes <ee21rh@surrey.ac.uk>
Subject: Re: Linux hangs during IDE initialization at boot for 30 sec
Date: Wed, 2 Feb 2005 14:20:14 +0000 (UTC)
Message-ID: <loom.20050202T151831-336@post.gmane.org>
References: <200502011257.40059.brade@informatik.uni-muenchen.de>  <pan.2005.02.01.20.21.46.334334@surrey.ac.uk> <1107299901.5624.28.camel@gaston> <loom.20050202T134427-571@post.gmane.org> <4200CD15.6080001@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 20.133.0.11 (Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.7.5) Gecko/20041107 Firefox/1.0)
X-Gmane-MailScanner: Found to be clean
X-Gmane-MailScanner: Found to be clean
X-MailScanner-From: glk-linux-kernel@m.gmane.org
X-MailScanner-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel <at> kolivas.org> writes:

> >>I'm not sure how the list of intefaces is probed on this machine, that's
> >>probably where the problem is.
> 
> I've read that people have had this problem go away if they disable this 
> option:
> 
> < >     generic/default IDE chipset support

Okay I'll try this tonight. I'm running a stock Fedora kernel at the moment
(rawhide) so this issue might affect more people than we think.
 
> If you have chipset support for your IDE controller this isn't needed, 
> and I'd recommend disabling it. The "why" it made the problem go away is 
> something I can't answer.

Richard.




