Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261466AbULIGYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261466AbULIGYo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 01:24:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261467AbULIGYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 01:24:44 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35725 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261464AbULIGYm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 01:24:42 -0500
Message-ID: <41B7EFA3.8000007@pobox.com>
Date: Thu, 09 Dec 2004 01:24:35 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg Stark <gsstark@mit.edu>
CC: linux-kernel@vger.kernel.org,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: SMART support for libata
References: <87y8g8r4y6.fsf@stark.xeocode.com>
In-Reply-To: <87y8g8r4y6.fsf@stark.xeocode.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Stark wrote:
> I don't mean to be a pest, I'm just curious what the status is of SMART
> support for libata. It doesn't look like it's mentioned in any of the status
> updates. Did I miss it? Is it relatively low priority after the hardware
> support? Is anyone interested in working on it? What has to be done?

The code exists in libata-dev queue.  It's currently waiting on official 
  SCSI opcode assignments, and someone to add code to filter out SET 
FEATURES - XFER MODE commands.

	Jeff


