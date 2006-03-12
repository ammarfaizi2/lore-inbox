Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751049AbWCLSQG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbWCLSQG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 13:16:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751610AbWCLSQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 13:16:05 -0500
Received: from p50915C03.dip.t-dialin.net ([80.145.92.3]:56450 "EHLO
	oscar.local.net") by vger.kernel.org with ESMTP id S1751049AbWCLSQE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 13:16:04 -0500
Date: Sun, 12 Mar 2006 19:15:48 +0100
From: Patrick Mau <mau@oscar.ping.de>
To: Eric.Brunet@lps.ens.fr
Cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Problem with a CD
Message-ID: <20060312181548.GA14889@oscar.prima.de>
References: <20060312162825.GA16993@platane.lps.ens.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060312162825.GA16993@platane.lps.ens.fr>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 12, 2006 at 05:28:25PM +0100, Eric.Brunet@lps.ens.fr wrote:
> Hi all,

Hi Eric,

<snip>

> eric sur esquilin ~ % md5sum /media/cdrom/*/*
> md5sum: /media/cdrom/cdi/cdi_imag.rtf: Erreur d'entrée/sortie
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 0ce73ce9f0954193b1e406f194ae7935  /media/cdrom/cdi/cdi_text.fnt
> acd74f592e10c130b1e16fb6987062bc  /media/cdrom/cdi/cdi_vcd.app
> 15b32fe29124c25c7218f350b9520e29  /media/cdrom/cdi/cdi_vcd.cfg
> 47ee5405eb0879a36aea7d5a420d9f3a  /media/cdrom/ext/lot_x.vcd
> b6219264a400936865906b925c33dcd6  /media/cdrom/ext/psd_x.vcd
> c3278fbe658bf842e14ff2f33967b064  /media/cdrom/ext/scandata.dat
> md5sum: /media/cdrom/mpegav/avseq01.dat: Erreur d'entrée/sortie
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 44f826b52e69fdd0398b05f06ef2ce62  /media/cdrom/vcd/entries.vcd
> 227a64758dcd545157873494b5cd7d8f  /media/cdrom/vcd/info.vcd
> 47ee5405eb0879a36aea7d5a420d9f3a  /media/cdrom/vcd/lot.vcd
> b6219264a400936865906b925c33dcd6  /media/cdrom/vcd/psd.vcd

> What could be the problem ?

Since this is a video cd, the files associated with the stream cannot
be accessed by mounting the medium. The filesystem of VCD is not a
normal filesystem, so you have to rip the video stream by using a tool
like vcdxrip.

On Debian the package is called 'vcdimager'.

Best regards,
Patrick
