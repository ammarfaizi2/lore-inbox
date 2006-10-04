Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422709AbWJDSD2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422709AbWJDSD2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 14:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161248AbWJDSCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 14:02:51 -0400
Received: from mx1.redhat.com ([66.187.233.31]:28583 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1422661AbWJDSCW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 14:02:22 -0400
Date: Wed, 4 Oct 2006 14:01:22 -0400
From: Dave Jones <davej@redhat.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: another attempt to kill off linux/config.h
Message-ID: <20061004180122.GC13079@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Arjan van de Ven <arjan@infradead.org>,
	Sam Ravnborg <sam@ravnborg.org>, Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20061004074434.GA13672@redhat.com> <20061004112450.GA6858@uranus.ravnborg.org> <1159962332.3000.15.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1159962332.3000.15.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2006 at 01:45:32PM +0200, Arjan van de Ven wrote:

 > > Removing it for real will be a pain for external modules.
 > > They could of course detect that it is missing and then
 > > drop it.
 > > I would suggest to keep the #warning in 2.6.19 and only
 > > remove it for real for 2.6.20.
 > 
 > they'll have to change anyway; delaying it one release doesn't actually
 > change that. And you can bet on most modules ignoring the warning anyway
 > and wait until the thing really is gone... making the value that this
 > extra delay has basically zero. While the cost is that more false users
 > will sneak into the kernel ;(

My thoughts exactly.  Since when did we give a damn about keeping
external modules compiling anyway?

 > Maybe Fedora can ship with an #error here early on; an #error at least
 > can provide a helpful message on how to fix it.

The #warn has been there for a few weeks in the fc6pre kernels, but it's
easily changed.

	Dave

-- 
http://www.codemonkey.org.uk
