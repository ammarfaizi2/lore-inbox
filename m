Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264233AbTLVSuX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 13:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264238AbTLVSuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 13:50:23 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:37287 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S264233AbTLVSuU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 13:50:20 -0500
Date: Mon, 22 Dec 2003 10:50:07 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Disconnect <lkml@sigkill.net>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Oops with 2.4.23
Message-ID: <20031222185007.GQ6438@matchmail.com>
Mail-Followup-To: Disconnect <lkml@sigkill.net>,
	lkml <linux-kernel@vger.kernel.org>
References: <20031219224402.GA1284@scrappy> <Pine.LNX.4.44.0312200034560.15516-100000@gaia.cela.pl> <20031222021659.GA4857@ip68-4-255-84.oc.oc.cox.net> <20031222120557.A21530@netdirect.ca> <1072118172.7007.32.camel@slappy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1072118172.7007.32.camel@slappy>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 22, 2003 at 01:36:12PM -0500, Disconnect wrote:
> Evidently many people can look at an oops or crash path and be 90%
> certain its bad/misperforming memory.  (How they do this I don't
> know..)  I've noticed that 'check your ram' is not always given as the
> answer, but it seems that most of the time when it is given its also
> correct.

Single bit changes on high bits (especially when they're not used in any bit
tests), are usually suspect from what I see on the list...
