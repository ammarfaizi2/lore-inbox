Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264629AbUFOABp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264629AbUFOABp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 20:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264643AbUFOABo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 20:01:44 -0400
Received: from mx1.redhat.com ([66.187.233.31]:2997 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264629AbUFOABb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 20:01:31 -0400
Date: Mon, 14 Jun 2004 17:01:20 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: "Bryan W. Headley" <bwheadley@earthlink.net>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       zaitcev@redhat.com
Subject: Re: drivers/usb/aiptek.c -- forgot minor patch to usbmouse.c
Message-Id: <20040614170120.530f0730@lembas.zaitcev.lan>
In-Reply-To: <40B0A544.7040404@earthlink.net>
References: <40AF85F9.9020500@earthlink.net>
	<20040522101508.34588e0e.zaitcev@redhat.com>
	<40B0A544.7040404@earthlink.net>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 May 2004 08:21:08 -0500
"Bryan W. Headley" <bwheadley@earthlink.net> wrote:

> So: purpose of patch: "release of the 1.5 version of the aiptek tablet 
> driver."

Bryan, I continue to sit on this, waiting for 2.6 to pick this up.
Are you doing anything to make it happen?

Meanwhile, a couple of small nits...

The stupidJavaCasingForVariables is something that will be over your
head forever. Why did you have to butcher a perfectly good open_count?

Now, about that  programmableDelay thingie. Why is it needed?
This one is a very transparent workaround for something.
It has to be justified.

-- Pete
