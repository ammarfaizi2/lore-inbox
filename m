Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751535AbVLFDQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751535AbVLFDQr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 22:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751539AbVLFDQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 22:16:46 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:11909
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1751532AbVLFDQq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 22:16:46 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: "Jonathan A. George" <jageorge@austin.rr.com>
Subject: Re: Unneeded RFC: Starting a stable kernel series off the 2.6 kernel
Date: Mon, 5 Dec 2005 17:59:56 -0600
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <43931829.60806@austin.rr.com>
In-Reply-To: <43931829.60806@austin.rr.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512051759.57060.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 04 December 2005 10:24, Jonathan A. George wrote:
> OTOH it would be nice if core userland (libc, udev, binutils,
> shellutils) were managed as a single project (as with OpenBSD) so that
> userland breakage would be better managed. :-)

Well, there's always the combination of busybox and uClibc. :)

But we don't do gcc, binutils, and make.  (There's tcc, but it doesn't quite 
build the unmodified kernel yet, doesn't do make, and its optimizer still 
sucks pretty badly...)

Rob
-- 
Steve Ballmer: Innovation!  Inigo Montoya: You keep using that word.
I do not think it means what you think it means.
