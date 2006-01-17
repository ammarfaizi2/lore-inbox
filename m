Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964799AbWAQUMi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964799AbWAQUMi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 15:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964798AbWAQUMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 15:12:38 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:62439 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S964799AbWAQUMi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 15:12:38 -0500
Date: Tue, 17 Jan 2006 21:12:37 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
cc: Willy Tarreau <willy@w.ods.org>,
       linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: X killed
In-Reply-To: <43CCE5C8.7030605@superbug.demon.co.uk>
Message-ID: <Pine.LNX.4.61.0601172111070.11929@yvahk01.tjqt.qr>
References: <43CA883B.2020504@superbug.demon.co.uk> <20060115192711.GO7142@w.ods.org>
 <43CCE5C8.7030605@superbug.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> My point is that there is no way to tell what kills me. No messages in
> syslog...nothing. Surely the OOM killer would send a message to ksyslog, or at
> least dmesg?
>
Yes, OOM usually does printk(). So it depends on how you have syslog set 
up (and the console loglevel - which is reponsible for bringing it right 
to console).


Jan Engelhardt
-- 
| Alphagate Systems, http://alphagate.hopto.org/
| jengelh's site, http://jengelh.hopto.org/
