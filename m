Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbUBTOcV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 09:32:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261192AbUBTOcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 09:32:21 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49082 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261210AbUBTOcU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 09:32:20 -0500
Message-ID: <40361A66.9060209@pobox.com>
Date: Fri, 20 Feb 2004 09:32:06 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: MALET JL <malet.jean-luc@laposte.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [drivers][sata-promise] TX4 has the cache enabled, it should
 be disabled
References: <4031DB3E.8000406@laposte.net> <40354871.1060009@pobox.com> <40360FDD.1070607@laposte.net>
In-Reply-To: <40360FDD.1070607@laposte.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MALET JL wrote:
> I relooked into manual (see promise site support, user manual)  and 
> there are two parameters for TX4 : write through/ write back , cache on 
> cache off..... I don't know which cache is it about but I'll redo some 
> test (argh you oblige me to reboot to windows! did you thought of my 
> uptime! LOL )this evening but as far as I remember the optimal values 
> where write through /no cache.....
> on windows with cache on their was small hangs too....
> I noticed then that a prempible kernel is not a good idea in my case : 
> lot more "small hangs"......


This would be the drive's cache, not the card's cache.

	Jeff



