Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262570AbTJJNlg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 09:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262571AbTJJNlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 09:41:36 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:63498 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S262570AbTJJNlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 09:41:35 -0400
Date: Fri, 10 Oct 2003 17:41:09 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Jamie Lokier <jamie@shareable.org>
Cc: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: USB and DMA on Alpha with 2.6.0-test7
Message-ID: <20031010174109.A12022@jurassic.park.msu.ru>
References: <yw1xu16hbg75.fsf@users.sourceforge.net> <20031010144710.A1396@jurassic.park.msu.ru> <20031010133104.GE28224@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20031010133104.GE28224@mail.shareable.org>; from jamie@shareable.org on Fri, Oct 10, 2003 at 02:31:04PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 10, 2003 at 02:31:04PM +0100, Jamie Lokier wrote:
> Isn't the device's dma_mask set equal to the controller's dma_mask
> automatically?

You are right, just check dma_mask of the device.

Anyway, as it is, usbnet driver won't work on i386 with
more than 4G of RAM and 32-bit DMA USB controller.

Ivan.
