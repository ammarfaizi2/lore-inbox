Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272580AbTHEIRd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 04:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272587AbTHEIQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 04:16:15 -0400
Received: from angband.namesys.com ([212.16.7.85]:35487 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S272580AbTHEIQK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 04:16:10 -0400
Date: Tue, 5 Aug 2003 12:16:08 +0400
From: Oleg Drokin <green@namesys.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Martin Konold <martin.konold@erfrakon.de>, linux-kernel@vger.kernel.org
Subject: Re: Interactive Usage of 2.6.0.test1 worse than 2.4.21
Message-ID: <20030805081608.GA14521@namesys.com>
References: <200308050704.22684.martin.konold@erfrakon.de> <20030804232654.295c9255.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030804232654.295c9255.akpm@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon, Aug 04, 2003 at 11:26:54PM -0700, Andrew Morton wrote:

> Try mounting your reiserfs filesystems with the "nolargeio" option.
> A `mount -o remount,nolargeio' will probably work too.

nolargeio requires an argument, so it should look like
mount -o remount,nolargeio=1

Bye,
    Oleg
