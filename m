Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315415AbSFEM76>; Wed, 5 Jun 2002 08:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315419AbSFEM75>; Wed, 5 Jun 2002 08:59:57 -0400
Received: from fachschaft.cup.uni-muenchen.de ([141.84.250.61]:43787 "EHLO
	fachschaft.cup.uni-muenchen.de") by vger.kernel.org with ESMTP
	id <S315415AbSFEM75>; Wed, 5 Jun 2002 08:59:57 -0400
Message-Id: <200206051253.g55Crs331876@fachschaft.cup.uni-muenchen.de>
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
To: Patrick Mochel <mochel@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: device model documentation 2/3
Date: Wed, 5 Jun 2002 14:51:08 +0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <Pine.LNX.4.33.0206040918490.654-100000@geena.pdx.osdl.net>
Cc: linux-hotplug-devel@lists.sourceforge.net,
        linux-usb-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> SUSPEND_DISABLE tells the device to stop I/O transactions. When it
> stops transactions, or what it should do with unfinished transactions
> is a policy of the driver. After this call, the driver should not
> accept any other I/O requests.

Does this mean that memory allocations in the suspend/resume
implementations must be made with GFP_NOIO respectively
GFP_ATOMIC ?
It would seem so.

	Regards
		Oliver
