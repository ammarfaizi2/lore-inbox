Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752059AbWFWVHZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752059AbWFWVHZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 17:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752060AbWFWVHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 17:07:25 -0400
Received: from THUNK.ORG ([69.25.196.29]:1988 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1752059AbWFWVHZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 17:07:25 -0400
Date: Fri, 23 Jun 2006 17:07:14 -0400
From: Theodore Tso <tytso@mit.edu>
To: Jeff Dike <jdike@addtoit.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm1: UML failing w/o SKAS enabled
Message-ID: <20060623210714.GA16661@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Jeff Dike <jdike@addtoit.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20060621034857.35cfe36f.akpm@osdl.org> <20060622213443.GA22303@thunk.org> <20060623024222.GA8316@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060623024222.GA8316@ccure.user-mode-linux.org>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2006 at 10:42:22PM -0400, Jeff Dike wrote:
> On Thu, Jun 22, 2006 at 05:34:43PM -0400, Theodore Tso wrote:
> > When I tried compiling 2.6.17-mm1 without SKAS support, it failed to
> > link:
> 
> Why are you trying to do that?  tt mode is bitrotting - the only
> reason it is still there is that skas mode doesn't fully support SMP
> yet.  If SMP is the reason, then I'll add the necessary support and
> send in the patch.

Well, because my host kernel is running a completely stock 2.6.17
kernel and so I don't have the SKAS patch applied.  If the goal is to
abandon tt mode, it would be really nice if the SKAS patch gets
integrated into mainline first....

						- Ted

