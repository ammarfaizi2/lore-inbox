Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261900AbVFIP1B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261900AbVFIP1B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 11:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261957AbVFIP1B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 11:27:01 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:3851 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S261900AbVFIPZT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 11:25:19 -0400
Message-ID: <42A85F5E.10208@rtr.ca>
Date: Thu, 09 Jun 2005 11:25:18 -0400
From: Mark Lord <liml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050420 Debian/1.7.7-2
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Greg Stark <gsstark@mit.edu>
Cc: linux-kernel@vger.kernel.org,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: SMART support for libata
References: <87y8g8r4y6.fsf@stark.xeocode.com> <41B7EFA3.8000007@pobox.com>	<87br6g6ayr.fsf@stark.xeocode.com> <42A73E6E.80808@rtr.ca> <873brs5ir8.fsf@stark.xeocode.com>
In-Reply-To: <873brs5ir8.fsf@stark.xeocode.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Stark wrote:
..
>>You should be using "-y" (standby) instead of "-Y" (sleep).
> 
> I'll try that. But that's not going to make it spin up when it gets a SMART
> query is it?

Depends on what SMART items are being queried.

Actually, what you should *really* be using is "hdparm -S"
with a suitable timeout value (say, 30 or larger).

Cheers

