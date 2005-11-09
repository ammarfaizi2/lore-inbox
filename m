Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965327AbVKIRWb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965327AbVKIRWb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 12:22:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030536AbVKIRW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 12:22:29 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:12960 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932574AbVKIRWS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 12:22:18 -0500
Subject: Re: [PATCH 0/39] NLKD - Novell Linux Kernel Debugger
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Jan Beulich <JBeulich@novell.com>, linux-kernel@vger.kernel.org
In-Reply-To: <43722AFC.4040709@pobox.com>
References: <43720DAE.76F0.0078.0@novell.com>  <43722AFC.4040709@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 09 Nov 2005 17:53:05 +0000
Message-Id: <1131558785.6540.34.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-11-09 at 11:59 -0500, Jeff Garzik wrote:
> Honestly, just seeing all these code changes makes me think we really 
> don't need it in the kernel.  How many "early" and "alternative" gadgets 
> do we really need just for this thing?

I think it is clearly the case that the design is wrong. The existance
of kgdb shows how putting the complex logic remotely on another system
is not only a lot cleaner and simpler but can also provide more
functionality and higher reliability.

The presence of user mode linux and Xen also provide solutions to the
usual concern about needing two systems, as will future hardware
features.

Alan

