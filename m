Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423515AbWJaRkM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423515AbWJaRkM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 12:40:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423609AbWJaRkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 12:40:12 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:37282 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1423515AbWJaRkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 12:40:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=KnkiCTTOSOBw6YoDwLoBD3fEVKBr7uPA2WOUgAi8hRsUyE8U2Xl9VK/wRU/1qzZ0z6rPMtiZ5FlfwS25v+BZRfNeLMyHQQZ0pilU+qST0+3I//6DmZS/vQidkySLfM5iCXYM2rsjyYxF0Y9imuJVfmx3FUySL1KQG9SuaDewaDs=
Date: Tue, 31 Oct 2006 18:40:06 +0100
From: Luca Tettamanti <kronos.it@gmail.com>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: linux-kernel@vger.kernel.org, John Richard Moser <nigelenki@comcast.net>,
       "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Suspend to disk:  do we HAVE to use swap?
Message-ID: <20061031174006.GA31555@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610311348.59069.s0348365@sms.ed.ac.uk>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair John Strachan <s0348365@sms.ed.ac.uk> ha scritto:
> On Tuesday 31 October 2006 06:16, Rafael J. Wysocki wrote:
> [snip]
>> However, we already have code that allows us to use swap files for the
>> suspend and turning a regular file into a swap file is as easy as running
>> 'mkswap' and 'swapon' on it.
> 
> How is this feature enabled? I don't see it in 2.6.19-rc4.

Swap files have been supported for ages. suspend-to-swapfile is very
new, you need a -mm kernel and userspace suspend from CVS:
http://suspend.sf.net

Luca
-- 
"Sei l'unica donna della mia vita".
(Adamo)
