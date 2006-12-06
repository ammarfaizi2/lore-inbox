Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760544AbWLFMRL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760544AbWLFMRL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 07:17:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760543AbWLFMRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 07:17:11 -0500
Received: from mtagate5.uk.ibm.com ([195.212.29.138]:22928 "EHLO
	mtagate5.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760544AbWLFMRK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 07:17:10 -0500
Mime-Version: 1.0
In-Reply-To: <200612051720.kB5HKU4i001616@dell2.home>
From: rainer@de.ibm.com (Rainer Bawidamann)
Subject: Re: ownership/permissions of cpio initrd
To: linux-kernel@vger.kernel.org
Cc: "Marty Leisner" <linux@rochester.rr.com>
Content-Type: text/plain; charset=us-ascii
Message-Id: <E1Grvi0-0002f9-9K@mogwai.local>
Date: Wed, 06 Dec 2006 13:17:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200612051720.kB5HKU4i001616@dell2.home>,
	"Marty Leisner" <linux@rochester.rr.com> writes:
> But its "useful" to change permissions/ownership of the initrd
> files at times...
> 
> Since a cpio is just a userspace created string of bits, I suppose
> you can apply a set of ownership/permissions to files IN the archive
> by playing with the bits...
> 
> Does such a tool exist?  Comments?  Seems very useful in order to
> avoid being root...

The kernel sources provide a program that should do what you want in

	linux/usr/gen_init_cpio.c

Documentation is available in the source or from the command line.

Rainer
