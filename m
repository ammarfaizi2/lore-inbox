Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932269AbWH3BND@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbWH3BND (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 21:13:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbWH3BNB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 21:13:01 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:49625 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932269AbWH3BNA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 21:13:00 -0400
Date: Wed, 30 Aug 2006 03:12:59 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 17/17] BLOCK: Make it possible to disable the block layer
 [try #2]
In-Reply-To: <44F44B8D.4010700@s5r6.in-berlin.de>
Message-ID: <Pine.LNX.4.64.0608300311430.6761@scrub.home>
References: <20060829115138.GA32714@infradead.org> <20060825142753.GK10659@infradead.org>
 <20060824213252.21323.18226.stgit@warthog.cambridge.redhat.com>
 <20060824213334.21323.76323.stgit@warthog.cambridge.redhat.com>
 <10117.1156522985@warthog.cambridge.redhat.com> <15945.1156854198@warthog.cambridge.redhat.com>
 <20060829122501.GA7814@infradead.org> <44F44639.90103@s5r6.in-berlin.de>
 <44F44B8D.4010700@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 29 Aug 2006, Stefan Richter wrote:

> An easy but crude fix would be to add an according hint at the help text of
> the immediately superordinate config option. E.g. at IEEE1394: "Also enable
> SCSI support to be able to switch on SBP-2 support (IEEE 1394 protocol e.g.
> for storage devices)." But this is extremely ugly /1./ because it would litter
> help texts of generic options with redundant information about specific
> options and /2./ because it requires users to find and read help texts in
> order to convince the configurator to make options visible.

You can also add a simple comment which is only visible if !SCSI.

bye, Roman
