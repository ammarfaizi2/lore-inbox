Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261185AbVALQDJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbVALQDJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 11:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbVALQDJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 11:03:09 -0500
Received: from village.ehouse.ru ([193.111.92.18]:9223 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S261185AbVALQDG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 11:03:06 -0500
From: "Sergey S. Kostyliov" <rathamahata@ehouse.ru>
Reply-To: "Sergey S. Kostyliov" <rathamahata@ehouse.ru>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Linux 2.6.11-rc1
Date: Wed, 12 Jan 2005 19:03:02 +0300
User-Agent: KMail/1.7.2
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0501112100250.2373@ppc970.osdl.org> <200501121824.44327.rathamahata@ehouse.ru> <Pine.LNX.4.58.0501120730490.2373@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0501120730490.2373@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501121903.02325.rathamahata@ehouse.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 12 January 2005 18:32, Linus Torvalds wrote:
> 
> On Wed, 12 Jan 2005, Sergey S. Kostyliov wrote:
> > 
> > 2.6.10-rc1 hangs at boot stage for my dual opteron machine
> 
> Oops, yes. There's some recent NUMA breakage - either disable CONFIG_NUMA, 
> or apply the patches that Andi Kleen just posted on the mailing list (the 
> second option much preferred, just to verify that yes, that does fix it).

That (numa x86_64 patchset from Andi Kleen) fixes it. Thanks for
a quick reply!

-- 
Sergey S. Kostyliov <rathamahata@ehouse.ru>
Jabber ID: rathamahata@jabber.org
