Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964877AbVHaQzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964877AbVHaQzU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 12:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964878AbVHaQzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 12:55:20 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:57759 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S964877AbVHaQzT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 12:55:19 -0400
Message-ID: <4315E0F0.6060209@pobox.com>
Date: Wed, 31 Aug 2005 12:55:12 -0400
From: Mark Lord <mlord@pobox.com>
Organization: Real-Time Remedies Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050728
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: APs from the Kernel Summit run Linux
References: <20050830093715.GA9781@midnight.suse.cz>
In-Reply-To: <20050830093715.GA9781@midnight.suse.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mmm.. curious sequence in the first 512 bytes of
the DWL-G730AP firmware binary.  It has this
sequence of bytes repeated several times:

   81 40 20 10 08 04 02 81 40 20 10 08 04 02 ...

That should be recognizable to somebody, I think.

I'll try loading the works into another ARM
system I have here, and see (1) if it runs as-is,
and (2) what the disassembly shows.

I'd certainly like to get source for my 730AP here,
as it seems to be a bit buggy on the WEP implementation.

Cheers
-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com

