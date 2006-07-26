Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751777AbWGZUIX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751777AbWGZUIX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 16:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbWGZUIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 16:08:23 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:24278 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751777AbWGZUIX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 16:08:23 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Al Boldi <a1426z@gawab.com>
Subject: Re: swsusp hangs on headless resume-from-ram
Date: Wed, 26 Jul 2006 22:07:46 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <200607262206.48801.a1426z@gawab.com>
In-Reply-To: <200607262206.48801.a1426z@gawab.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607262207.46773.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 26 July 2006 21:06, Al Boldi wrote:
> 
> swsusp is really great, most of the time.  But sometimes it hangs after 
> coming out of STR.  I suspect it's got something to do with display access, 
> as this problem seems hw related.  So I removed the display card, and it 
> positively does not resume from ram on 2.6.16+.
> 
> Any easy fix for this?

I have one idea, but you'll need a patch to test.  I'll try to prepare it tomorrow.

I guess your box is an i386?

Rafael
