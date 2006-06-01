Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965127AbWFASss@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965127AbWFASss (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 14:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965212AbWFASsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 14:48:47 -0400
Received: from rtr.ca ([64.26.128.89]:36737 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S965127AbWFASsr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 14:48:47 -0400
Message-ID: <447F368F.2080305@rtr.ca>
Date: Thu, 01 Jun 2006 14:48:47 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: State of resume for AHCI?
References: <447F23C2.8030802@goop.org> <447F3250.5070101@rtr.ca>
In-Reply-To: <447F3250.5070101@rtr.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> The one-line "resume fix" (attached) *might* be all that you need.
> This is in current Linus 2.6.17-rc*-git*

Oh.. yes, you'll have to switch to the ata_piix driver for this to work.
So long as your AHCI is an Intel one, that will probably work fine.

Cheers
