Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932445AbWDMSy1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932445AbWDMSy1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 14:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932446AbWDMSy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 14:54:27 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:11961 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932445AbWDMSy1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 14:54:27 -0400
Date: Thu, 13 Apr 2006 20:54:17 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jan Knutar <jk-lkml@sci.fi>
cc: "Martin J. Bligh" <mbligh@mbligh.org>, K P <kplkml@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: JVM performance on Linux (vs. Solaris/Windows)
In-Reply-To: <200604132121.42662.jk-lkml@sci.fi>
Message-ID: <Pine.LNX.4.61.0604132052450.20938@yvahk01.tjqt.qr>
References: <62a080740604130753i4b8bbbckc3cba12092b54226@mail.gmail.com>
 <443E74C1.5090801@mbligh.org> <200604132121.42662.jk-lkml@sci.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> SpecJBB is a really frigging stupid benchmark. It's *much* more affected
>> by the stupid crap in Java (like their locking model) than anything in the
>> OS. 
>
>What's even worse is that people actually code by this stupid model...
> 
And since it lacks pointers and some other 'fun', things have to be coded 
multiple times and/or differently, which leads to increased code size 
and/or execution time (neglecting the fact it's already a VM).


Jan Engelhardt
-- 
