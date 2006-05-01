Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbWEAABS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbWEAABS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 20:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750700AbWEAABS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 20:01:18 -0400
Received: from smtp114.sbc.mail.mud.yahoo.com ([68.142.198.213]:3762 "HELO
	smtp114.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750745AbWEAABR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 20:01:17 -0400
Date: Sun, 30 Apr 2006 17:01:15 -0700
From: Chris Wedgwood <cw@f00f.org>
To: masouds@masoud.ir
Cc: jeff@garzik.org, gregkh@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [BUG] VIA quirk fixup failure after 2.6.17-rc3
Message-ID: <20060501000115.GA8831@taniwha.stupidest.org>
References: <20060430162820.GA18666@masoud.ir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060430162820.GA18666@masoud.ir>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 30, 2006 at 09:28:20AM -0700, masouds@masoud.ir wrote:

> My machine's tulip card stopped working after I updated to 2.6.17-rc3.git3
> which included 75cf7456dd87335f574dcd53c4ae616a2ad71a11 patch of
> yours. Revesing it made the problem go away; Is there a chance that a VIA
> pci_id was missed from the list of quirks in your patch?

it sounds like it

i just grepped the pci_ids.h again and didn't see one missing, could you
also send me the output of "lspci -n" please?
