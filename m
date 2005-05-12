Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261953AbVELSdb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261953AbVELSdb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 14:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262032AbVELSdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 14:33:31 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:22422 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S261953AbVELSd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 14:33:26 -0400
Date: Thu, 12 May 2005 14:33:25 -0400
To: jmerkey <jmerkey@utah-nac.org>
Cc: Scott Robert Ladd <lkml@coyotegulch.com>, linux-kernel@vger.kernel.org
Subject: Re: Automatic .config generation
Message-ID: <20050512183325.GA23621@csclub.uwaterloo.ca>
References: <42839AF7.4030708@coyotegulch.com> <42838D4C.3040207@utah-nac.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42838D4C.3040207@utah-nac.org>
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2005 at 11:07:24AM -0600, jmerkey wrote:
> Scott Robert Ladd wrote:
> >Is there a utility that creates a .config based on analysis of the
> >target system?
> 
> Now that's a great idea ..... :-) 

And how would it guess if you want iptables support enabled or not?
Which device drivers to include is not the only thing that goes in
.config after all.

A simpler solution is turn on everything as modules, and let
hotplug/discover figure it out at boot time. :)

Len Sorensen
