Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265121AbUGMNYL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265121AbUGMNYL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 09:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265100AbUGMNYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 09:24:11 -0400
Received: from rogue.ncsl.nist.gov ([129.6.101.41]:28370 "EHLO
	rogue.ncsl.nist.gov") by vger.kernel.org with ESMTP id S265121AbUGMNYI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 09:24:08 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: SATA disk device naming ?
References: <Pine.LNX.4.44.0407130415430.15806-100000@hubble.stokkie.net>
	<20040713064645.GA1660@bounceswoosh.org>
From: Ian Soboroff <ian.soboroff@nist.gov>
Date: Tue, 13 Jul 2004 09:24:06 -0400
In-Reply-To: <20040713064645.GA1660@bounceswoosh.org> (Eric D. Mudama's
 message of "Tue, 13 Jul 2004 00:46:45 -0600")
Message-ID: <9cfhdsc82h5.fsf@rogue.ncsl.nist.gov>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric D. Mudama" <edmudama@bounceswoosh.org> writes:

> On Tue, Jul 13 at  4:25, Robert M. Stockmann wrote:
>>Is there in such cases a smart workaround available, maybe as an extra
>> GRUB/LILO boot option ? And why was the device naming changed in
>> such a fatal way, effectively going from IDE to SCSI device names.
>
> Google on the "root=LABEL=/" syntax supported by both LILO and grub (I
> think), should point you in the proper direction.  Then it won't
> matter where/how you mount your drives, they'll still boot and mount
> into the proper places in the filesystem.

Did the patch for labeling the swap partition ever make it into the
kernel?

Also, if your filesystems are modular (e.g. XFS) then labels may not
help at boot time.

Ian


