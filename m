Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964885AbWGEUsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964885AbWGEUsX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 16:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964896AbWGEUsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 16:48:23 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:38854 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S964885AbWGEUsW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 16:48:22 -0400
Date: Wed, 5 Jul 2006 22:48:21 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org,
       bernds_cb1@t-online.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] FDPIC: Fix FDPIC compile errors [try #2]
Message-ID: <20060705204821.GA20456@mars.ravnborg.org>
References: <20060705175440.12594.43069.stgit@warthog.cambridge.redhat.com> <20060705175443.12594.30741.stgit@warthog.cambridge.redhat.com> <20060705124142.7bec7597.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060705124142.7bec7597.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2006 at 12:41:42PM -0700, Andrew Morton wrote:
> Methinks it actually fixes a warning, which was promoted to an error by
> -Werror.  Which was fixed by adding an unneeded assignment, all becasue gcc
> is dumb.
No -Werror in fs/ neither in -mm not in -linus?

	Sam
