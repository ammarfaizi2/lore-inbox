Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161121AbWGIUY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161121AbWGIUY7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 16:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161118AbWGIUY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 16:24:59 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:45700 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161121AbWGIUY7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 16:24:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=A8pJ/cR4gDxQswipMDPzDriZ4vM5RR3/BBw6WVlPx/w5bt8ZWMnfBdObO4MbXhAW2mKSxu0VTAJxIg2rjj4bgktm/UcABeC+Wl+koSmsbpv95M/LDgOrI802ujPUsZZZ5M5zOvcvvxtMTAUGhnUJTSz2IISjZBbRF6tlDEr4VDM=
Date: Sun, 9 Jul 2006 22:24:01 +0200
From: Diego Calleja <diegocg@gmail.com>
To: "Daniel Bonekeeper" <thehazard@gmail.com>
Cc: bunk@stusta.de, linux-kernel@vger.kernel.org
Subject: Re: Automatic Kernel Bug Report
Message-Id: <20060709222401.52168a58.diegocg@gmail.com>
In-Reply-To: <e1e1d5f40607091301j723b92bje147932a4395775c@mail.gmail.com>
References: <e1e1d5f40607090145k365c0009ia3448d71290154c@mail.gmail.com>
	<6bffcb0e0607090245t2dbcd394n86ce91eec661f215@mail.gmail.com>
	<e1e1d5f40607090329i25f6b1b2s3db2c2001230932c@mail.gmail.com>
	<20060709125805.GF13938@stusta.de>
	<e1e1d5f40607091146s2f8e6431v33923f38c6d10539@mail.gmail.com>
	<20060709191107.GN13938@stusta.de>
	<e1e1d5f40607091301j723b92bje147932a4395775c@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.18; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Sun, 9 Jul 2006 16:01:58 -0400,
"Daniel Bonekeeper" <thehazard@gmail.com> escribió:

> Independent of wheter you think that this is useful or not, do you see
> any cleaner way to send those reports, having in mind that the
> userspace may not be responsive ?

Kdump (http://lse.sourceforge.net/kdump/) would be useful for
many cases.

WRT to the bugs where the system completely locks up and doesn't
leaves any option for automatic bug reports: You don't really care
about those, because they're _so_ annoying that people reports them
manually.
