Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030316AbWARN6d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030316AbWARN6d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 08:58:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030315AbWARN6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 08:58:32 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:52388 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030314AbWARN6c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 08:58:32 -0500
Date: Wed, 18 Jan 2006 07:58:26 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PID virtualisation snafu
Message-ID: <20060118135826.GA9743@sergelap.austin.ibm.com>
References: <20060117161543.GJ19769@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060117161543.GJ19769@parisc-linux.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthew Wilcox (matthew@wil.cx):
> 
> Are there any web archives of l-k that give out the email address of
> the author?

Regardless, that was me.

> I can tell the author of the virtualisation patches hasn't even tried to
> compile them.  Here's one example:

Not only compiled, but on several architectures.  Thanks for
catching this.  And your point is well taken - these need to be
tested with 'make allmodconfig', since the pid accesses happen
in all sorts of drivers...

thanks,
-serge
