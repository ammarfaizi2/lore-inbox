Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932085AbWJEOen@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbWJEOen (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 10:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932083AbWJEOem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 10:34:42 -0400
Received: from ns1.suse.de ([195.135.220.2]:22979 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932085AbWJEOem (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 10:34:42 -0400
From: Andreas Schwab <schwab@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Reenable SCSI=m
References: <jemz8bvsnn.fsf@sykes.suse.de> <20061005130921.GF16812@stusta.de>
X-Yow: I've gotta GO, now!!  I wanta tell you you're a GREAT bunch of guys
 but you ought to CHANGE your UNDERWEAR more often!!
Date: Thu, 05 Oct 2006 16:34:40 +0200
In-Reply-To: <20061005130921.GF16812@stusta.de> (Adrian Bunk's message of
	"Thu, 5 Oct 2006 15:09:21 +0200")
Message-ID: <jebqoqx24f.fsf@sykes.suse.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> writes:

> On Thu, Oct 05, 2006 at 02:44:28PM +0200, Andreas Schwab wrote:
>
>> Since CONFIG_SCSI (a tristate) now depends on CONFIG_BLOCK (a bool) it is
>> no longer possible to set CONFIG_SCSI=m.
>>...
>
> A tristate depending on a bool is a common case that works just fine and 
> allows the modular setting.

You are right.  My problem was that I said CONFIG_ATA=y when I meant
CONFIG_ATA=m which forced CONFIG_SCSI=y behind by back.  It didn't occur
to me that this was related.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
