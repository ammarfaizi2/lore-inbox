Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264935AbTLWDrT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 22:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264937AbTLWDrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 22:47:18 -0500
Received: from 12-211-66-152.client.attbi.com ([12.211.66.152]:22925 "EHLO
	waltsathlon.localhost.net") by vger.kernel.org with ESMTP
	id S264935AbTLWDrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 22:47:17 -0500
Message-ID: <3FE7BAC4.2040901@comcast.net>
Date: Mon, 22 Dec 2003 19:47:16 -0800
From: Walt H <waltabbyh@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031121
X-Accept-Language: en-us
MIME-Version: 1.0
To: Nicklas Bondesson <nikomail@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Error mounting root fs on 72:01 using Promise FastTrak TX2000
 (PDC20271)
References: <BAY8-DAV33OyDc41W2u00002b2b@hotmail.com>
In-Reply-To: <BAY8-DAV33OyDc41W2u00002b2b@hotmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicklas Bondesson wrote:
> The patch did not work for me, in fact there was no change at all (anything
> affected to me). The Promise ataraid driver never gets loaded.
> 
> /Nicke 

Not sure what else to try. I see that you've already posted to the ata-raid
list, so I'd hope that somebody else would reply from there. The pdcraid driver
has not received much attention lately, so it may very well be broken for your
configuration. Promise has released a binary/source combo driver similar to
Nvidia's that will still work in 2.4 - you might give that a try. I have a
PDC20276 based onboard raid setup, however, I use 2.6 with device mapper to use
it. It's a bit of a pain to setup ATM - especially if you want to boot from it,
but it can be done. Good luck,

-Walt


