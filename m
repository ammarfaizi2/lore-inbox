Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263478AbTKKMNN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 07:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263486AbTKKMNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 07:13:12 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:64902 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S263478AbTKKMNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 07:13:11 -0500
Date: Tue, 11 Nov 2003 10:13:08 -0200
From: Flavio Bruno Leitner <fbl@conectiva.com.br>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE disk information changed from 2.4 to 2.6
Message-ID: <20031111121308.GA1750@conectiva.com.br>
References: <20031105172310.GE5304@conectiva.com.br> <20031111114649.GA16163@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20031111114649.GA16163@win.tue.nl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 11, 2003 at 12:46:49PM +0100, Andries Brouwer wrote:
> On Wed, Nov 05, 2003 at 03:23:10PM -0200, Flavio Bruno Leitner wrote:
> 
> > Upgrading from kernel 2.4 to 2.6 the CHS information for the same hardware 
> > changed. This behaviour is correct? 
> > 
> > Using 2.4:
> > hda: 12594960 sectors (6449 MB) w/2048KiB Cache, CHS=784/255/63, UDMA (33)
> > 
> > Using 2.6:
> > hda: 12594960 sectors (6449 MB) w/2048KiB Cache, CHS=13328/15/63, UDMA (33)
> 
> Yes, correct in the sense that it is not wrong.
> Probably your disk reports 15 and 2.4 invented 255.
> 
> CHS is something that stopped being meaningful a decade ago.
> Today it is random garbage, to be ignored whenever possible.
> Don't worry about CHS when you don't have problems.

Parted was complaining about this change but I still have to check with 
version of parted they used. Anyway, it's booting and working normaly.

Regards,

-- 
Flávio Bruno Leitner <fbl@conectiva.com.br>
[ E74B 0BD0 5E05 C385 239E  531C BC17 D670 7FF0 A9E0 ]
