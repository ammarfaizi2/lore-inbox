Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266031AbUGTRQv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266031AbUGTRQv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 13:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266034AbUGTRQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 13:16:51 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:46461 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S266031AbUGTRQu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 13:16:50 -0400
Date: Tue, 20 Jul 2004 21:17:21 +0200
From: sam@ravnborg.org
To: Idan Spektor <idan@imperva.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: module name is KBUILD_MODNAME
Message-ID: <20040720191721.GA9147@mars.ravnborg.org>
Mail-Followup-To: Idan Spektor <idan@imperva.com>,
	linux-kernel@vger.kernel.org
References: <96242ACDF1723A4BBF70D21211FB9B2306368E@shrek.webcohort.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96242ACDF1723A4BBF70D21211FB9B2306368E@shrek.webcohort.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 20, 2004 at 05:36:01PM +0200, Idan Spektor wrote:
> Hi All,
> I am migrating my loadable module to work with the 2.6 kernel.
> I have actually managed to make everything working except for
> one thing. When I am loading my module (using the new
> modprobe), its name, as appearing in lsmod, is KBUILD_MODNAME instead
> of the module's real name. What am I missing? Is there
> a define for the module's name that I should add somewhere?

For a start could you post the Makefile you use to build the module?
I assume you use the kbuild infrastructure?

	Sam
