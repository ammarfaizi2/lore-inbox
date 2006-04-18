Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932306AbWDRUGc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbWDRUGc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 16:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932307AbWDRUGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 16:06:32 -0400
Received: from [81.2.110.250] ([81.2.110.250]:23751 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932306AbWDRUGc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 16:06:32 -0400
Subject: Re: [RFC] Watchdog device class
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rudolf Marek <r.marek@sh.cvut.cz>
Cc: wim@iguana.be, linux-kernel@vger.kernel.org
In-Reply-To: <4445318B.1040800@sh.cvut.cz>
References: <4443EED9.30603@sh.cvut.cz>
	 <1145309500.14497.6.camel@localhost.localdomain>
	 <4445318B.1040800@sh.cvut.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 18 Apr 2006 21:16:09 +0100
Message-Id: <1145391369.21723.31.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-04-18 at 20:35 +0200, Rudolf Marek wrote:
> timeout - timeout value in sec - convert it to ms perhaps?

Probably

> ping - "ping" file, to replace the /dev/watchdog writes

Well you need to keep /dev/watchdog but yes

> As for the temps/fans I belive the driver should register in hwmon class and use
> hwmon class sysfs iterface and then just create sort of relation between the
> sysfs files/classes, so the watchdog app can find the temps.

I think that is appropriate. The temperature and watchdog association is
mostly historical because in the past thats where temp sensors lived,
nowdays they are everywhere.


Alan

