Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261288AbVGVOdr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbVGVOdr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 10:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262092AbVGVObp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 10:31:45 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:50157 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262096AbVGVO3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 10:29:43 -0400
Subject: Re: 2.6.13-rc3-mm1 (ckrm)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: Gerrit Huizenga <gh@us.ibm.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0507220033371.4935-100000@coffee.psychology.mcmaster.ca>
References: <Pine.LNX.4.44.0507220033371.4935-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 22 Jul 2005 15:53:55 +0100
Message-Id: <1122044035.9478.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-07-22 at 00:53 -0400, Mark Hahn wrote:
> the fast path slower and less maintainable.  if you are really concerned
> about isolating many competing servers on a single piece of hardware, then
> run separate virtualized environments, each with its own user-space.

And the virtualisation layer has to do the same job with less
information. That to me implies that the virtualisation case is likely
to be materially less efficient, its just the inefficiency you are
worried about is hidden in a different pieces of code.

Secondly a lot of this doesnt matter if CKRM=n compiles to no code
anyway

