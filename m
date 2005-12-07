Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751203AbVLGQv1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbVLGQv1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 11:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbVLGQv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 11:51:27 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:47070 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S1751203AbVLGQv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 11:51:26 -0500
Date: Wed, 7 Dec 2005 14:51:13 -0200
From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       ehabkost@mandriva.com
Subject: Re: [PATCH 00/10] usb-serial: Switches from spin lock to atomic_t.
Message-Id: <20051207145113.4cbdc264.lcapitulino@mandriva.com.br>
In-Reply-To: <20051207164118.GA28032@suse.de>
References: <20051206095610.29def5e7.lcapitulino@mandriva.com.br>
	<20051207164118.GA28032@suse.de>
Organization: Mandriva
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Dec 2005 08:41:18 -0800
Greg KH <gregkh@suse.de> wrote:

| On Tue, Dec 06, 2005 at 09:56:10AM -0200, Luiz Fernando Capitulino wrote:
| >  Greg,
| > 
| >  Don't get scared. :-)
| 
| I'm not scared, just not liking this patch series at all.
| 
| In the end, it's just moving from one locking scheme to another.  No big
| deal.

 I understand.

| The problem is, none of this should be needed at all.  We need to move
| the usb-serial drivers over to use the serial core code.  If that
| happens, then none of this locking is needed.
| 
| That's the right thing to do, so I'm not going to take this patch series
| right now because of that.  If you all want to work on moving to use the
| serial core, I would love to see that happen.

 If it's the right thing to do, I'll love to work on that. :)

 There is only one problem though, I've never touched in the serial core.
It means I'll need some time to do it, and maybe the first tries can be
wrong.

 Any tips you have in mind are very welcome.

 Eduardo, let's do it? :)

-- 
Luiz Fernando N. Capitulino
