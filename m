Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271402AbRHOUQr>; Wed, 15 Aug 2001 16:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271404AbRHOUQh>; Wed, 15 Aug 2001 16:16:37 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:27434 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S271402AbRHOUQ3>; Wed, 15 Aug 2001 16:16:29 -0400
Date: Wed, 15 Aug 2001 22:16:23 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Joe Thornber <thornber@btconnect.com>
Cc: Kurt Garloff <garloff@suse.de>, linux-lvm@sistina.com,
        lvm-devel@sistina.com, linux-kernel@vger.kernel.org
Subject: Re: [linux-lvm] Re: *** ANNOUNCEMENT *** LVM 1.0 available at www.sistina.com
Message-ID: <20010815221623.C11146@athlon.random>
In-Reply-To: <20010815175659.A29749@sistina.com> <20010815182548.U3941@gum01m.etpnet.phys.tue.nl> <20010815185005.A32239@sistina.com> <20010815190428.A11146@athlon.random> <20010815210622.A1221@btconnect.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010815210622.A1221@btconnect.com>; from thornber@btconnect.com on Wed, Aug 15, 2001 at 09:06:22PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2001 at 09:06:22PM +0100, Joe Thornber wrote:
> In previous beta releases of LVM the PE position was always being
> calculated, rather than calculated upon PV creation and put in the
> metadata.  I was not aware of this.
> 
> This calculation varied through the beta series, it was based on some
> constants that I changed (eg, SECTOR_SIZE which I changed to support

You can put the algorithm used by beta7 in a separate program and ask
this program where the pe start. Since the beta7 tools knows where the
pe_start (the proof is that I can use lvm in my machines), also this new
program will know where the pe_start.

Andrea
