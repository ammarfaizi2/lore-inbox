Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263204AbUGMGqH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263204AbUGMGqH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 02:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263429AbUGMGqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 02:46:07 -0400
Received: from 80-169-17-66.mesanetworks.net ([66.17.169.80]:37806 "EHLO
	mail.bounceswoosh.org") by vger.kernel.org with ESMTP
	id S263204AbUGMGqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 02:46:05 -0400
Date: Tue, 13 Jul 2004 00:46:45 -0600
From: "Eric D. Mudama" <edmudama@bounceswoosh.org>
To: "Robert M. Stockmann" <stock@stokkie.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SATA disk device naming ?
Message-ID: <20040713064645.GA1660@bounceswoosh.org>
Mail-Followup-To: "Robert M. Stockmann" <stock@stokkie.net>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0407130415430.15806-100000@hubble.stokkie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0407130415430.15806-100000@hubble.stokkie.net>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13 at  4:25, Robert M. Stockmann wrote:
>Is there in such cases a smart workaround available, maybe as an extra
>GRUB/LILO boot option ? And why was the device naming changed in 
>such a fatal way, effectively going from IDE to SCSI device names.

Google on the "root=LABEL=/" syntax supported by both LILO and grub (I
think), should point you in the proper direction.  Then it won't
matter where/how you mount your drives, they'll still boot and mount
into the proper places in the filesystem.

--eric


-- 
Eric D. Mudama
edmudama@mail.bounceswoosh.org

