Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968679AbWLEUhV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968679AbWLEUhV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 15:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968678AbWLEUhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 15:37:20 -0500
Received: from mailer.gwdg.de ([134.76.10.26]:46097 "EHLO mailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968676AbWLEUhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 15:37:19 -0500
Date: Tue, 5 Dec 2006 21:32:52 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
cc: Jeffrey Hundstad <jeffrey.hundstad@mnsu.edu>,
       Marty Leisner <linux@rochester.rr.com>, linux-kernel@vger.kernel.org,
       bug-cpio@gnu.org, martin.leisner@xerox.com
Subject: Re: ownership/permissions of cpio initrd 
In-Reply-To: <200612052024.kB5KOY1o023781@laptop13.inf.utfsm.cl>
Message-ID: <Pine.LNX.4.61.0612052131370.18570@yvahk01.tjqt.qr>
References: <200612052024.kB5KOY1o023781@laptop13.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> You can also use fakeroot(1).
>
>I think that is a debianism... not here on Fedora.

	LKML is (hopefully) distro neutral.

That useless line aside, the linux kernel build process supports 
creating a cpio archive with privileged things (devices) as a normal 
user.

	-`J'
-- 
