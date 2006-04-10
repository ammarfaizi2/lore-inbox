Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932122AbWDJTYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbWDJTYJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 15:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbWDJTYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 15:24:08 -0400
Received: from khc.piap.pl ([195.187.100.11]:17167 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S932122AbWDJTYI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 15:24:08 -0400
To: Andy Green <andy@warmcat.com>
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
	Cc:	unlisted-recipients:; (no To-header on input)linux list <linux-kernel@vger.kernel.org>
								     ^-missing end of address
Subject: Re: Black box flight recorder for Linux
References: <44379AB8.6050808@superbug.co.uk>
	<m3psjqeeor.fsf@defiant.localdomain> <443A4927.5040801@warmcat.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Mon, 10 Apr 2006 21:24:01 +0200
In-Reply-To: <443A4927.5040801@warmcat.com> (Andy Green's message of "Mon, 10 Apr 2006 13:01:43 +0100")
Message-ID: <m3odz9kze6.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Green <andy@warmcat.com> writes:

> Just an additional thought on this idea... both VGA and DVI connectors
> on modern video cards appear to have DDC-2 connections, which is in
> fact I2C.

Yes, that could be used, too. It would be a bit more complicated as
different VGA cards use different access methods (i.e., different
I/O port and bit numbers). X11 drivers probably know how to drive it.
-- 
Krzysztof Halasa
