Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263159AbUFSURS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263159AbUFSURS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 16:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264627AbUFSURS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 16:17:18 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9949 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263159AbUFSURR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 16:17:17 -0400
Message-ID: <40D49F3C.8060408@pobox.com>
Date: Sat, 19 Jun 2004 16:17:00 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Justin Cormack <justin@street-vision.com>
CC: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [libata] quick fix for vendor and model names
References: <1081274055.18070.29.camel@lotte.street-vision.com>
In-Reply-To: <1081274055.18070.29.camel@lotte.street-vision.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Cormack wrote:
> ok, so transport attributes arent happening for libata. Howabout this
> little patch to fix up the vendor and model names in the common case
> when they are 3 chars + 16 chars (like almost all hard drives) so the
> model names arent truncated in this case. Otherwise leaves things as
> they are.

This isn't true for Maxtor or Seagate, two high-volume ATA device vendors.

	Jeff



