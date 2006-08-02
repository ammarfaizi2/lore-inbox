Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751334AbWHBJbX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbWHBJbX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 05:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbWHBJbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 05:31:22 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:16005 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1751334AbWHBJbW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 05:31:22 -0400
Message-ID: <44D070E7.3080707@drzeus.cx>
Date: Wed, 02 Aug 2006 11:31:19 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Alex Dubov <oakad@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Support for TI FlashMedia (pci id 104c:8033, 104c:803b) flash
 card readers
References: <20060802021227.19174.qmail@web36713.mail.mud.yahoo.com>
In-Reply-To: <20060802021227.19174.qmail@web36713.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Dubov wrote:
> I was working on making some sense from all the
> constants and discovered that many flashmedia mmc
> registers are very similar in bit assignment to OMAP
> mmc ones (which are documented). Pity I haven't
> noticed it before. I'll take some time now to review
> the driver given this new information.
>
>   

Nice. Hope you find something.

> But what with mmc_host structure that also hangs
> around? I think it deserves the name "host" even more.
>
>   

Perhaps. But the other drivers have chosen to use "mmc" for the mmc_host
structure and "host" for their internal state structure. It's really a
matter of taste, but it's easier to do changes that cover all/many
drivers when they all use the same naming conventions.

Rgds
Pierre

