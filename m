Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261930AbVEaROs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261930AbVEaROs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 13:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261985AbVEaRMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 13:12:38 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:23175 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261930AbVEaRF1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 13:05:27 -0400
X-Envelope-From: kraxel@suse.de
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: mrmacman_g4@mac.com, toon@hout.vanvergehaald.nl, ltd@cisco.com,
       linux-kernel@vger.kernel.org, dtor_core@ameritech.net, 7eggert@gmx.de
Subject: Re: OT] Joerg Schilling flames Linux on his Blog
References: <26A66BC731DAB741837AF6B2E29C10171E60DE@xmb-hkg-413.apac.cisco.com>
	<20050530093420.GB15347@hout.vanvergehaald.nl>
	<429B0683.nail5764GYTVC@burner>
	<46BE0C64-1246-4259-914B-379071712F01@mac.com>
	<429C4483.nail5X0215WJQ@burner>
From: Gerd Knorr <kraxel@suse.de>
Organization: SUSE Labs, Berlin
Date: 31 May 2005 18:59:01 +0200
In-Reply-To: <429C4483.nail5X0215WJQ@burner>
Message-ID: <87acmbxrfu.fsf@bytesex.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling <schilling@fokus.fraunhofer.de> writes:

> If you use /dev/ entries to directly address SCSI targets, then you 
> are relying on on assumptions that cannot be granted everywhere.
>
> Cdrecord is portable and this needs to implement a way that is portable 
> and does not rely on nonportable assumptions like yours.

Not really.  Yes, it runs on different operating systems.  But to send
the SCSI commands to the device you have OS-specific code in there,
simply because it's handled in different ways on Solaris / Linux /
whatever OS.  You could make the device addressing OS-specific as well
instead of expecting everyone in the world follow the Solaris model,
that would make life a bit easier for everyone involved.

Addressing IDE devices (try to get a real SCSI burner these days)
using scsi host+target+lun is sort-of silly IMHO ...

  Gerd
