Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263812AbTKXT0v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 14:26:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263821AbTKXT0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 14:26:51 -0500
Received: from bab72-140.optonline.net ([167.206.72.140]:59242 "EHLO
	shookay.newview.com") by vger.kernel.org with ESMTP id S263812AbTKXT0s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 14:26:48 -0500
To: Valdis.Kletnieks@vt.edu
Cc: splite@purdue.edu, root@chaos.analogic.com, linux-kernel@vger.kernel.org
Subject: Re: hard links create local DoS vulnerability and security proble
References: <200311241829.hAOITdKL014364@turing-police.cc.vt.edu>
X-Face: %JOeya=Dg!}[/#Go&*&cQ+)){p1c8}u\Fg2Q3&)kothIq|JnWoVzJtCFo~4X<uJ\9cHK'.w 3:{EoxBR
From: Mathieu Chouquet-Stringer <mathieu@newview.com>
Date: 24 Nov 2003 14:25:31 -0500
In-Reply-To: <200311241829.hAOITdKL014364@turing-police.cc.vt.edu>
Message-ID: <xltptfhd0wk.fsf@shookay.newview.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu writes:
> mkdir ~/bin
> chmod 700 ~/bin
> cat > ~/bin/show-me
> #!/bin/sh
> whoami
> ^D
> chmod 4755 ~/bin/show-me
> 
> No separate partitions needed.

It's always been my understanding that you cannot have suid shell script
because you could easily change the IFS. Am i wrong? (

-- 
Mathieu Chouquet-Stringer              E-Mail : mathieu@newview.com
       Never attribute to malice that which can be adequately
                    explained by stupidity.
                     -- Hanlon's Razor --
