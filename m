Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129199AbQJaIpV>; Tue, 31 Oct 2000 03:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129203AbQJaIpM>; Tue, 31 Oct 2000 03:45:12 -0500
Received: from Cantor.suse.de ([194.112.123.193]:8 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129199AbQJaIow>;
	Tue, 31 Oct 2000 03:44:52 -0500
Date: Tue, 31 Oct 2000 09:44:45 +0100
From: Andi Kleen <ak@suse.de>
To: Brian Gerst <bgerst@didntduck.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: kmalloc() allocation.
Message-ID: <20001031094445.A24901@gruyere.muc.suse.de>
In-Reply-To: <E13qJZL-00076K-00@the-village.bc.nu> <Pine.LNX.3.95.1001030133720.3346A-100000@chaos.analogic.com> <8tll94$hc9$1@cesium.transmeta.com> <39FE6291.FA8162A7@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <39FE6291.FA8162A7@didntduck.org>; from bgerst@didntduck.org on Tue, Oct 31, 2000 at 01:11:29AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2000 at 01:11:29AM -0500, Brian Gerst wrote:
> This was just changed in 2.4 so that vmalloced pages are faulted in on
> demand.

Could you explain how it handles the vmalloc() -- vfree() -- vmalloc() of same
virtual space but different physical race ? 

-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
