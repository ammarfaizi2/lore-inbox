Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264268AbUDNQLI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 12:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264274AbUDNQLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 12:11:07 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:55434 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S264268AbUDNQLE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 12:11:04 -0400
Date: Wed, 14 Apr 2004 18:18:27 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: walt <wa1ter@myrealbox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.5-bk]  'modules_install' failed to install modules
Message-ID: <20040414161827.GA2229@mars.ravnborg.org>
Mail-Followup-To: walt <wa1ter@myrealbox.com>,
	linux-kernel@vger.kernel.org
References: <407D5B7F.107@myrealbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <407D5B7F.107@myrealbox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2004 at 08:40:47AM -0700, walt wrote:
> I pulled the latest changesets just now and found this weird behavior:
> 
> 'make' and 'make install' worked as expected, but 'make modules_install'
> just deleted all the old modules, ran depmod, and then installed no new
> modules -- nothing.
> 
> I finally found that doing another 'make' fixed whatever the problem
> was and allowed modules_install to work properly the second time.
> 
> This happened on two different machines, so I'm fairly sure it wasn't
> just me having a brainfart.

This is my second report about this.
But you gave some new info "work properly the second time".
This was not the case for the other person.

I will look into it tonight.

	Sam
