Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262317AbUJ0IEd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262317AbUJ0IEd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 04:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262322AbUJ0IEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 04:04:33 -0400
Received: from sd291.sivit.org ([194.146.225.122]:60349 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S262317AbUJ0IE1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 04:04:27 -0400
Date: Wed, 27 Oct 2004 10:05:41 +0200
From: Stelian Pop <stelian@popies.net>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH 0/5] Sonypi driver model & PM changes
Message-ID: <20041027080541.GA3882@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Dmitry Torokhov <dtor_core@ameritech.net>,
	LKML <linux-kernel@vger.kernel.org>, Vojtech Pavlik <vojtech@suse.cz>
References: <20041026155639.42445.qmail@web81306.mail.yahoo.com> <20041026180932.GA17655@deep-space-9.dsnet> <200410262156.52832.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410262156.52832.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2004 at 09:56:50PM -0500, Dmitry Torokhov wrote:

> On Tuesday 26 October 2004 01:09 pm, Stelian Pop wrote:
> > > Btw, you should probably drop conditional support for input layer
> > > and always compile it in.
> > 
> > Is CONFIG_INPUT now a requirement for the (at least i386) kernel ?
> > If this is the case, I'll drop the conditional. 
> > 
> 
> While it can be disabled when one selects !EMBEDDED I doubt hi/she will
> be interested in sonnypi in this case :). For all practical reasons input
> layer is always present.

Ok. I'll remove the ifdefs and make SONYPI depend on INPUT in Kconfig.

Stelian.
-- 
Stelian Pop <stelian@popies.net>    
