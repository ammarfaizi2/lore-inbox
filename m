Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751455AbWJPD5F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751455AbWJPD5F (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 23:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbWJPD5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 23:57:05 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:7196 "EHLO
	asav05.insightbb.com") by vger.kernel.org with ESMTP
	id S1751455AbWJPD5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 23:57:04 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AesRADGfMkWBSoQmhiss
From: Dmitry Torokhov <dtor@insightbb.com>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] hwmon/abituguru: handle sysfs errors
Date: Sun, 15 Oct 2006 23:56:59 -0400
User-Agent: KMail/1.9.3
Cc: Hans de Goede <j.w.r.degoede@hhs.nl>, Jeff Garzik <jeff@garzik.org>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
References: <20061010065359.GA21576@havoc.gtf.org> <200610120031.20097.dtor@insightbb.com> <20061012174214.81afe0b2.khali@linux-fr.org>
In-Reply-To: <20061012174214.81afe0b2.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610152357.02429.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 October 2006 11:42, Jean Delvare wrote:
> Hi Dmitry,
> 
> Dmitry Torokhov wrote:
> > I know I sound like a roken record but this driver would benefit from
> > using attribute_group.
> 
> What about sending a patch then?
> 

Sorry, spoke too soon. Because the driver uses non-satic attributes
converting it to use attribute_group would probably be messier than
the present code.

-- 
Dmitry
