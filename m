Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263764AbTEYUwJ (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 25 May 2003 16:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263765AbTEYUwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 16:52:09 -0400
Received: from crack.them.org ([146.82.138.56]:43495 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id S263764AbTEYUwG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 16:52:06 -0400
Date: Sun, 25 May 2003 17:05:07 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: must-fix list, v5
Message-ID: <20030525210507.GA18707@nevyn.them.org>
Mail-Followup-To: Andrew Morton <akpm@digeo.com>,
	linux-kernel@vger.kernel.org
References: <20030521152255.4aa32fba.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030521152255.4aa32fba.akpm@digeo.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 21, 2003 at 03:22:55PM -0700, Andrew Morton wrote:
> 
> Also at ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/must-fix/
> 
> For verson 6 I shall go through the "late features" list and prioritise
> things.

Here's another one for your list: when CLONE_DETACHED threads were
removed from /proc several approaches were suggested to let procps find
out about them and none of them were implemented.  There's some real
potential for badness with these mostly-invisible processes.  Something
needs to be added so that we can display and detect them.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
