Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbTIKPko (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 11:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261306AbTIKPko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 11:40:44 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:35851 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP id S261304AbTIKPkm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 11:40:42 -0400
Date: Thu, 11 Sep 2003 16:40:37 +0100
From: John Levon <levon@movementarian.org>
To: Jani Monoses <jani@iv.ro>
Cc: linux-kernel@vger.kernel.org
Subject: Re: about kernel/ksyms.c
Message-ID: <20030911154037.GB46513@compsoc.man.ac.uk>
References: <20030911114557.219e45b7.jani@iv.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030911114557.219e45b7.jani@iv.ro>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: King of Woolworths - L'Illustration Musicale
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19xTYj-0000qZ-6Y*8pjrayz52V6*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 11, 2003 at 11:45:57AM +0300, Jani Monoses wrote:

> what is the reason for symbols being exported from ksyms.c instead of
> the files they are defined in?

Historically you had to explicitly specify which files exported symbols
in the makefile. That's not true any more, and recent style seems to be
to do what you suggest. But it's not really worth the trouble of
redistributing the stuff in ksyms.c except as part of other patches IMHO

regards
john

-- 
Khendon's Law:
If the same point is made twice by the same person, the thread is over.
