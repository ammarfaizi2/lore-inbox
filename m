Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264511AbTDPSDw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 14:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264531AbTDPSDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 14:03:51 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:52628 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S264511AbTDPSDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 14:03:51 -0400
Date: Wed, 16 Apr 2003 14:09:07 -0400
From: Ben Collins <bcollins@debian.org>
To: Philippe Gramoull? <philippe.gramoulle@mmania.com>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>, linux1394-devel@lists.sourceforge.net
Subject: Re: 2.5.67-mm3: Bad: scheduling while atomic with IEEE1394 then hard freeze ( lockup on CPU0)
Message-ID: <20030416180906.GN16706@phunnypharm.org>
References: <20030416000501.342c216f.philippe.gramoulle@mmania.com> <20030415160530.2520c61c.akpm@digeo.com> <20030416004933.GI16706@phunnypharm.org> <20030416184528.19c20372.philippe.gramoulle@mmania.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030416184528.19c20372.philippe.gramoulle@mmania.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 16, 2003 at 06:45:28PM +0200, Philippe Gramoull? wrote:
> Hello,
> 
> On Tue, 15 Apr 2003 20:49:33 -0400
> Ben Collins <bcollins@debian.org> wrote:
> 
>   | > The 1394 warnings are known about and I think Ben is working on it.
>   | 
>   | Yeah, they are fixed in the linux1394 tree. I'm getting ready to push
>   | them to Linus.
> 
> You mean the tree available with :
> 
> svn checkout svn://svn.linux1394.org/ieee1394/trunk/ ieee1394 ?
> 
> Because i tried with checkouted revision 867 few minutes ago and i still have the "bad: scheduling
> while atomic!" message when i rmmod the modules ( modules init tools were upgraded to 0.9.11a)
> 
> DV camcorder still doesn't seem to work ( with dvgrab for example )

Thanks, this was one I wasn't aware of.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
