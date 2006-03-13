Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932292AbWCMAno@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292AbWCMAno (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 19:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbWCMAno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 19:43:44 -0500
Received: from cfa.harvard.edu ([131.142.10.1]:38378 "EHLO cfa.harvard.edu")
	by vger.kernel.org with ESMTP id S932292AbWCMAnn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 19:43:43 -0500
Date: Sun, 12 Mar 2006 19:43:41 -0500 (EST)
From: Gaspar Bakos <gbakos@cfa.harvard.edu>
Reply-To: gbakos@cfa.harvard.edu
To: Jiri Slaby <jirislaby@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15 -- unable to open an initial console
In-Reply-To: <Pine.SOL.4.58.0603121842110.22310@cfassp0.cfa.harvard.edu>
Message-ID: <Pine.SOL.4.58.0603121943030.22310@cfassp0.cfa.harvard.edu>
References: <E1FIZ9B-00089K-00@decibel.fi.muni.cz>
 <Pine.SOL.4.58.0603121842110.22310@cfassp0.cfa.harvard.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Problem solved.
The new kernel config was missing the support for ramdisk (I have no
idea why). Now, with ramdisk support, everything works fine. Actually
there is nothing to do, just

cd linux-2.6.15.6; make; make modules_install install; lilo; reboot

Thanks again for the clues.
Gaspar
