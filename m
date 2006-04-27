Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965134AbWD0PAT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965134AbWD0PAT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 11:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965135AbWD0PAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 11:00:19 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:33154 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S965134AbWD0PAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 11:00:18 -0400
Date: Thu, 27 Apr 2006 17:00:17 +0200
From: Martin Mares <mj@ucw.cz>
To: Avi Kivity <avi@argo.co.il>
Cc: Denis Vlasenko <vda@ilport.com.ua>, Kyle Moffett <mrmacman_g4@mac.com>,
       Roman Kononov <kononov195-far@yahoo.com>,
       LKML Kernel <linux-kernel@vger.kernel.org>
Subject: Re: C++ pushback
Message-ID: <mj+md-20060427.145744.9154.atrey@ucw.cz>
References: <20060426034252.69467.qmail@web81908.mail.mud.yahoo.com> <4EE8AD21-55B6-4653-AFE9-562AE9958213@mac.com> <44507BB9.7070603@argo.co.il> <200604271655.48757.vda@ilport.com.ua> <4450D4E9.4050606@argo.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4450D4E9.4050606@argo.co.il>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> As an example, you can easily get C++ to inline the hash function in a 
> generic hashtable or the compare in a sort. I dare you to do it in C.

As you wish :-)

http://atrey.karlin.mff.cuni.cz/~mj/tmp/hashtable.h

It's somewhat ugly inside, but an equally strong generic structure build
with templates will be probably even uglier.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Immanuel doesn't pun, he Kant.
