Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264266AbUE2Lfw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264266AbUE2Lfw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 07:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264268AbUE2Lfw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 07:35:52 -0400
Received: from gprs214-173.eurotel.cz ([160.218.214.173]:48512 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S264266AbUE2Lfp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 07:35:45 -0400
Date: Sat, 29 May 2004 13:35:34 +0200
From: Pavel Machek <pavel@suse.cz>
To: Stuart Young <cef-lkml@optusnet.com.au>
Cc: linux-kernel@vger.kernel.org, Nigel Cunningham <ncunningham@linuxmail.org>,
       Rob Landley <rob@landley.net>, seife@suse.de
Subject: Re: swappiness=0 makes software suspend fail.
Message-ID: <20040529113534.GB25121@elf.ucw.cz>
References: <200405280000.56742.rob@landley.net> <20040528215642.GA927@elf.ucw.cz> <200405291905.20925.cef-lkml@optusnet.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405291905.20925.cef-lkml@optusnet.com.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Stefan, we may want to do echo 100 > /proc/sys/vm/swappiness in
> > suspend script...
> 
> Really, you should save that value somewhere and then restore it after 
> suspend, or those people who do use /proc/sys/vm/swappiness will likely 
> complain about it (ie: me).

Yes, that was what I meant.
								Pavel
-- 
934a471f20d6580d5aad759bf0d97ddc
