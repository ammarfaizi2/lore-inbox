Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264286AbUDNRA7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 13:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264280AbUDNRA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 13:00:59 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:29362 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S264288AbUDNRA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 13:00:56 -0400
Date: Wed, 14 Apr 2004 18:00:10 +0100
From: Dave Jones <davej@redhat.com>
To: walt <wa1ter@myrealbox.com>, linux-kernel@vger.kernel.org
Subject: Re: [2.6.5-bk]  'modules_install' failed to install modules
Message-ID: <20040414170010.GA23419@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	walt <wa1ter@myrealbox.com>, linux-kernel@vger.kernel.org
References: <407D5B7F.107@myrealbox.com> <20040414161827.GA2229@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040414161827.GA2229@mars.ravnborg.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2004 at 06:18:27PM +0200, Sam Ravnborg wrote:
 > On Wed, Apr 14, 2004 at 08:40:47AM -0700, walt wrote:
 > > I pulled the latest changesets just now and found this weird behavior:
 > > 
 > > 'make' and 'make install' worked as expected, but 'make modules_install'
 > > just deleted all the old modules, ran depmod, and then installed no new
 > > modules -- nothing.
 > > 
 > > I finally found that doing another 'make' fixed whatever the problem
 > > was and allowed modules_install to work properly the second time.
 > > 
 > > This happened on two different machines, so I'm fairly sure it wasn't
 > > just me having a brainfart.
 > 
 > This is my second report about this.
 > But you gave some new info "work properly the second time".
 > This was not the case for the other person.

Make this the third.  I just saw it happen here too.
'make bzImage ; make modules ; make modules_install' fails in the above way.
Doing a 'make' seems to work.

		Dave
