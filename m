Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751240AbVKNTAK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbVKNTAK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 14:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbVKNTAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 14:00:09 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:35343 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1751240AbVKNTAI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 14:00:08 -0500
Date: Mon, 14 Nov 2005 20:00:07 +0100
From: Olivier Galibert <galibert@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
Message-ID: <20051114190007.GA72044@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	linux-kernel@vger.kernel.org
References: <20051114133802.38755.qmail@web50205.mail.yahoo.com> <1131979779.5751.17.camel@localhost.localdomain> <dlal2q$kdo$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dlal2q$kdo$1@sea.gmane.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2005 at 01:29:54PM -0500, Giridhar Pemmasani wrote:
> Any suggestions on how ndiswrapper can live with this patch would be greatly
> appreciated.

Couldn't ndiswrapper have its own private stack to switch to when
calling the windows driver, or are there still things hanging off the
end of the stack area?

  OG.

