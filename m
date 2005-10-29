Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751047AbVJ2HME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047AbVJ2HME (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 03:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbVJ2HME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 03:12:04 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:15816
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1751047AbVJ2HMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 03:12:02 -0400
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Evgeny Stambulchik <Evgeny.Stambulchik@weizmann.ac.il>
Subject: Re: Weirdness of "mount -o remount,rw" with write-protected floppy
Date: Fri, 28 Oct 2005 20:29:46 -0500
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <4360C0A7.4050708@weizmann.ac.il> <200510280850.40609.rob@landley.net> <43623B1B.50309@weizmann.ac.il>
In-Reply-To: <43623B1B.50309@weizmann.ac.il>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510282029.46913.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 October 2005 09:52, Evgeny Stambulchik wrote:
> You're right, when I mount the floppy with "-o sync", touch fails
> immediately (I did try earlier sync(1), as somebody suggested, and it
> didn't matter; yes, I know about the difference between sync(2) and
> fsync(2)). On the other hand, umount is supposed to flush all the data
> by the time it returns yet still it succeeded.

Is that guaranteed?  Or do you need to pass some weird flag to umount?  (I 
know there's lazy unmounts, for example.  I don't know what the guarantees 
are for standard unmounts...)

Rob
