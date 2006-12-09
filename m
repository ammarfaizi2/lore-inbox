Return-Path: <linux-kernel-owner+w=401wt.eu-S1759275AbWLIHb2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759275AbWLIHb2 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 02:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759285AbWLIHb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 02:31:28 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:35621 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759275AbWLIHb1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 02:31:27 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <457A663A.5080308@s5r6.in-berlin.de>
Date: Sat, 09 Dec 2006 08:31:06 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061202 SeaMonkey/1.0.6
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Kristian_H=F8gsberg?= <krh@redhat.com>
CC: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] Import fw-ohci driver.
References: <20061205052229.7213.38194.stgit@dinky.boston.redhat.com> <20061205052245.7213.39098.stgit@dinky.boston.redhat.com> <45750A89.7000802@garzik.org> <457A1A93.5090707@redhat.com>
In-Reply-To: <457A1A93.5090707@redhat.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kristian Høgsberg wrote:
> Yup, I've done away with the bitfields and switched to a mix of __le16
> and __le32 struct fields.

I suppose the struct should get __attribute__((packed)) then.

But is the order of two adjacent __le16 fields (i.e. two halves of a
quadlet) independent of host byte order?
-- 
Stefan Richter
-=====-=-==- ==-- -=--=
http://arcgraph.de/sr/
