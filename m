Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268295AbUJDQIc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268295AbUJDQIc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 12:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268296AbUJDQI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 12:08:28 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:53176 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S268281AbUJDQIU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 12:08:20 -0400
Message-ID: <4161750A.6060200@rtr.ca>
Date: Mon, 04 Oct 2004 12:06:34 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: William Knop <wknop@andrew.cmu.edu>
Cc: Jon Lewis <jlewis@lewis.org>, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: libata badness
References: <Pine.LNX.4.60-041.0410040656001.2350@unix48.andrew.cmu.edu> <Pine.LNX.4.58.0410040953160.26615@web1.mmaero.com> <Pine.LNX.4.60-041.0410041132070.9105@unix43.andrew.cmu.edu>
In-Reply-To: <Pine.LNX.4.60-041.0410041132070.9105@unix43.andrew.cmu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have used Maxtor "SATA" drives that require
the O/S to do a "SET FEATURES :: UDMA_MODE" command
on them before they will operate reliably.
This despite the SATA spec stating clearly that
such a command should/will have no effect.

I suppose libata does this already, but just in case not..
Something simple to check up on.
-- 
Mark Lord
(hdparm keeper & the original "Linux IDE Guy")

William Knop wrote:
>
> Ah, well all of them are Maxtor drives... One 6y250m0 and three 7y250m0 
> drives. I'm using powermax on them right now. They all passed the quick 
> test, and the full test results are forthcoming.
