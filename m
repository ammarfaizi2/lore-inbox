Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317981AbSGWHfO>; Tue, 23 Jul 2002 03:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317983AbSGWHfO>; Tue, 23 Jul 2002 03:35:14 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:55049 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S317981AbSGWHfO>; Tue, 23 Jul 2002 03:35:14 -0400
Date: Tue, 23 Jul 2002 08:38:18 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: kirk@braille.uwo.ca, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-rc3-ac2
Message-ID: <20020723083818.A19154@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Adrian Bunk <bunk@fs.tum.de>, kirk@braille.uwo.ca,
	linux-kernel@vger.kernel.org
References: <200207230022.g6N0Mgh30698@devserv.devel.redhat.com> <Pine.NEB.4.44.0207230925360.10993-100000@mimas.fachschaften.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.NEB.4.44.0207230925360.10993-100000@mimas.fachschaften.tu-muenchen.de>; from bunk@fs.tum.de on Tue, Jul 23, 2002 at 09:34:22AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2002 at 09:34:22AM +0200, Adrian Bunk wrote:
> 
> drivers/char/Makefile includes speakup/speakupmap.o that was already
> included in speakup/spk.o and the fix is simple:

I think it makes more sense to remove it from drivers/char/speakup/Makefile.

