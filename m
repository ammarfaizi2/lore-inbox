Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932339AbWF0NeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbWF0NeF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 09:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbWF0NeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 09:34:05 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:50352 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S932339AbWF0NeE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 09:34:04 -0400
Date: Tue, 27 Jun 2006 15:34:02 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: lib(p)ata SMART support?
Message-ID: <20060627133401.GM3114@harddisk-recovery.com>
References: <200606271555.13330.arvidjaar@mail.ru> <20060627121649.GL3114@harddisk-recovery.com> <200606271646.41294.arvidjaar@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606271646.41294.arvidjaar@mail.ru>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2006 at 04:46:39PM +0400, Andrey Borzenkov wrote:
> On Tuesday 27 June 2006 16:16, Erik Mouw wrote:
> > Try smartctl -d ata.
> >
> 
> Right, it works. thank you. I wonder if it possible to automatically find the 
> correct device type?

The current implementation guesses the device type by device name,
which apparently doesn't work with libata. I don't know if there's a
better way to figure out.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
