Return-Path: <linux-kernel-owner+w=401wt.eu-S1751763AbXAOAip@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751763AbXAOAip (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 19:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751764AbXAOAip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 19:38:45 -0500
Received: from usul.saidi.cx ([204.11.33.34]:35182 "EHLO usul.overt.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751763AbXAOAio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 19:38:44 -0500
Message-ID: <45AACCE9.8080405@overt.org>
Date: Sun, 14 Jan 2007 16:38:01 -0800
From: Philip Langdale <philipl@overt.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Pierre Ossman <drzeus-list@drzeus.cx>
CC: LAK <linux-arm-kernel@lists.arm.linux.org.uk>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] MMC: Major restructuring and cleanup
References: <459CB3D2.4010707@drzeus.cx> <45A9BF57.7050408@overt.org> <45AA2AD7.70607@drzeus.cx>
In-Reply-To: <45AA2AD7.70607@drzeus.cx>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Ossman wrote:
 >
> Eeeeww... This is a problem as the SD spec. clearly states the order of
> init commands. So I wouldn't be surprised if we find SD cards that choke
> on the MMC init sequence.
> 
> I guess what we lose by not supporting these is 8 bit data bus, but as
> we do not currently have a controller for that I think the point is moot.

Hrm. Even the MMC 4.1 App Note describes a unified init sequence where SD is
checked first.

So, these cards are essentially useless then. The number of hosts that support
MMC 4 but not SD can probably be counted on no hands. :-)

--phil
