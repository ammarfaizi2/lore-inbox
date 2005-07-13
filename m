Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262735AbVGMUBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262735AbVGMUBj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 16:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262741AbVGMUB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 16:01:26 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:45835 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S262748AbVGMT70
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 15:59:26 -0400
Date: Wed, 13 Jul 2005 21:47:03 +0000
From: Sam Ravnborg <sam@ravnborg.org>
To: Karl Hegbloom <hegbloom@pdx.edu>
Cc: Kai Germaschewski <kai@germaschewski.name>, linux-kernel@vger.kernel.org
Subject: Re: PATCH Makefile, Make 'cscope -q' play well with cscope.el
Message-ID: <20050713214703.GD16374@mars.ravnborg.org>
References: <87br62hjjc.fsf@journeyhawk.karlheg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87br62hjjc.fsf@journeyhawk.karlheg.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 19, 2005 at 12:50:47AM -0700, Karl Hegbloom wrote:
> LinuxVersion: 2.6-git 2005/06/19
> 
> I tried the Linux Makefile 'make cscope' target, and found that the
> generated database is not compatible with 'cscope.el' under XEmacs.
> The thing is that 'cscope.el' does not allow setting the command line
> options to the 'cscope' commands it runs, and it errors with a message
> about the options not matching the ones used to generate the index.
> 
> It turns out the cscope designers already thought of this.  The
> options can be written into the "cscope.files".  The included patch
> moves the "-q" and "-k" options from the 'cmd_cscope' to the
> 'cmd_cscope-file', echoing them into the top of the files listing.
> 
> Now the index is generated with the "-q" option, and when 'cscope.el'
> performs it's search, it uses that argument as well.  Lookups are fast
> and everyone is happy.

Applied - thanks.

	Sam
