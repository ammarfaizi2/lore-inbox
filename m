Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262805AbTKJU6g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 15:58:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262813AbTKJU6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 15:58:36 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39842 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262805AbTKJU6f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 15:58:35 -0500
Message-ID: <3FAFFBEE.2020904@pobox.com>
Date: Mon, 10 Nov 2003 15:58:22 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lutz Bichler <Lutz.Bichler@unibw-muenchen.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: PCNET32 - Driver
References: <200311101857.25806.Lutz.Bichler@unibw-muenchen.de>
In-Reply-To: <200311101857.25806.Lutz.Bichler@unibw-muenchen.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lutz Bichler wrote:
> Hi,
> 
> i needed to add the following code snippet to the pcnet32 - driver in order to 
> make it work with new Allied Telesync fiber channel cards. 
> 
> 600,603d599
> <     case 0x2628:
> <         chipname = "PCnet/FAST III 79C976";
> <         fdx = 1; mii = 1;
> <         break;
> 
>>From the drivers source it is not clear to me who actually maintains the 
> driver. Who is the maintainer and how can i get this (or something better of 
> course) merged into the driver? Please CC as i am not subscribed to the list.


If you can CC me on "diff -u" patches, I'll make sure they go in.

	Jeff



