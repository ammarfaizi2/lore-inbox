Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261387AbTEAPkS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 11:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbTEAPkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 11:40:18 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:28690 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S261387AbTEAPkR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 11:40:17 -0400
Date: Thu, 1 May 2003 17:52:38 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andi Kleen <ak@suse.de>
Cc: Kimmo Sundqvist <rabbit80@mbnet.fi>, linux-kernel@vger.kernel.org,
       akpm@digeo.com
Subject: Re: 2.5.68-mm3 and a simple mistake
Message-ID: <20030501155238.GA1018@mars.ravnborg.org>
Mail-Followup-To: Andi Kleen <ak@suse.de>,
	Kimmo Sundqvist <rabbit80@mbnet.fi>, linux-kernel@vger.kernel.org,
	akpm@digeo.com
References: <200305011826.31389.rabbit80@mbnet.fi.suse.lists.linux.kernel> <p734r4e3ca6.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p734r4e3ca6.fsf@oldwotan.suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 01, 2003 at 05:41:05PM +0200, Andi Kleen wrote:
> +
> +EXTRA_CFLAGS	+= -I../kernel

This assignment is not needed AFAICS.
Needs to be removed from a couple of i386 Makefiles, which I will do soon.

	Sam
