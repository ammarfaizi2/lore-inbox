Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751168AbWFRWuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbWFRWuF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 18:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbWFRWuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 18:50:05 -0400
Received: from animx.eu.org ([216.98.75.249]:53700 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S1751168AbWFRWuE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 18:50:04 -0400
Date: Sun, 18 Jun 2006 18:52:00 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: emergency or init=/bin/sh mode and terminal signals
Message-ID: <20060618225200.GB30726@animx.eu.org>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	linux-kernel@vger.kernel.org
References: <20060618212303.GD4744@bouh.residence.ens-lyon.fr> <20060618223906.GA30726@animx.eu.org> <20060618224051.GE4744@bouh.residence.ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060618224051.GE4744@bouh.residence.ens-lyon.fr>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Samuel Thibault wrote:
> Wakko Warner, le Sun 18 Jun 2006 18:39:06 -0400, a ?crit :
> > why not only set this if the shell is /bin/sh ?
> 
> Because you can't know that. /bin/sh is one example of shell, /bin/ash
> is another /usr/bin/myprog is yet another...

I realized that before I sent the email.  /bin/sh is guaranteed (usually) to
be there.  I myself prefer zsh, but when I'm booting with init=, it's always
/bin/sh (unless I'm testing something else).  Of course, that's just me. 
The one time I did use init=/bin/zsh, it failed to function properly (forgot
the details), but booting with /bin/sh and exec zsh worked fine.

Is there any (non-embedded) linux systems out there that do not have
/bin/sh ?  On the boot cd I built, there is no /bin/sh but there is a
/bin/init (shell script with #! busybox ash  at the top)

Anyway, it's a thought.  Or you could only enable it if the init= is not
init (Any other inits?)

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
 Got Gas???
