Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261334AbVE0CAy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261334AbVE0CAy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 22:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261383AbVE0CAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 22:00:53 -0400
Received: from mail.dvmed.net ([216.237.124.58]:20188 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261334AbVE0CAu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 22:00:50 -0400
Message-ID: <42967F4A.9030705@pobox.com>
Date: Thu, 26 May 2005 22:00:42 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
CC: Mark Lord <liml@rtr.ca>, Jens Axboe <axboe@suse.de>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: [PATCH][RFT] libata: fix use-after-free during driver unload/unplug
References: <42962379.5000206@pobox.com> <42964099.6000207@pobox.com> <42967601.7080003@pobox.com> <429678B0.7000009@rtr.ca>
In-Reply-To: <429678B0.7000009@rtr.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Attached is the patch I committed, please test.

