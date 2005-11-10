Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932110AbVKJU62@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbVKJU62 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 15:58:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbVKJU62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 15:58:28 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:26244 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S1750757AbVKJU61
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 15:58:27 -0500
Date: Thu, 10 Nov 2005 21:59:31 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Jan Beulich <JBeulich@novell.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/39] NLKD - early/late CPU up/down notification
Message-ID: <20051110205931.GC7584@mars.ravnborg.org>
References: <43720DAE.76F0.0078.0@novell.com> <43720E2E.76F0.0078.0@novell.com> <43720E72.76F0.0078.0@novell.com> <43720EAF.76F0.0078.0@novell.com> <20051109164544.GB32068@kroah.com> <43723B57.76F0.0078.0@novell.com> <20051109171919.GA32761@kroah.com> <437307BC.76F0.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <437307BC.76F0.0078.0@novell.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I understand that. But you don't see my point, so I'll try to explain
> the background: When discovering the reason for the kallsyms change
> (also posted with the other NLKD patches) not functioning with
> CONFIG_MODVERSIONS and binutils between 2.16.90 and 2.16.91.0.3 I
> realized that the warning messages from the modpost build stage are very
> easy to overlook (in fact, all reporters of the problem overlooked them
> as well as I did on the first build attempting to reproduce the
> problem). This basically means these messages are almost useless, and
> detection of the problem will likely be deferred to the first attempt to
> load an offending module (which, as in the case named, may lead to an
> unusable kernel). Hence, at least until this build problem gets
> addressed I continue to believe that adding the preprocessor conditional
> is the better way of dealing with potential issues.

Can you elaborate a little what you like to have done to the build
process.

	Sam
