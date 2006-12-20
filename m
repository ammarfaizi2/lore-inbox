Return-Path: <linux-kernel-owner+w=401wt.eu-S932661AbWLTUeo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932661AbWLTUeo (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 15:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932701AbWLTUen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 15:34:43 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:56517 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932661AbWLTUen (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 15:34:43 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <45899E4B.2060401@s5r6.in-berlin.de>
Date: Wed, 20 Dec 2006 21:34:19 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061202 SeaMonkey/1.0.6
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Kristian_H=F8gsberg?= <krh@redhat.com>
CC: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: Re: [PATCH 0/4] New firewire stack - updated patches
References: <20061220005822.GB11746@devserv.devel.redhat.com> <458913AC.7080300@s5r6.in-berlin.de> <45897478.6070308@redhat.com> <45898785.4000209@s5r6.in-berlin.de>
In-Reply-To: <45898785.4000209@s5r6.in-berlin.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:
> Kristian Høgsberg wrote:
[eth1394]
>> The only thing I've ever heard people say about it is that it's
>> annoying because it screws up their network interface ordering.
> 
> Yeah, the same way hot-pluggable SCSI devices screw up device naming of

(I forgot to complete the post.) ... fixed SCSI devices and among
themselves. That's old and continues to become apparent with more and
more types of hardware. The solution is old too; distributors should be
aware of it.

That said, the way how eth1394 is married with ieee1394 could stand
improvement. There should be an option (and it should be the default) to
let eth1394 load its ROM entries == don't automatically modprobe eth1394
as soon as the low level set up a host adapter.
-- 
Stefan Richter
-=====-=-==- ==-- =-=--
http://arcgraph.de/sr/
