Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262596AbTJFShP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 14:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262597AbTJFShO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 14:37:14 -0400
Received: from moutng.kundenserver.de ([212.227.126.183]:22011 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262596AbTJFShL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 14:37:11 -0400
Message-ID: <3F81B66F.5070701@onlinehome.de>
Date: Mon, 06 Oct 2003 20:37:35 +0200
From: Hans-Georg Thien <1682-600@onlinehome.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5a) Gecko/20030718
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gabriel Paubert <paubert@iram.es>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: getting timestamp of last interrupt?
References: <fa.fj0euih.s2sbop@ifi.uio.no> <fa.ch95hks.10kepak@ifi.uio.no> <3F7E46EE.1020201@onlinehome.de> <20031006152632.GA3419@iram.es>
In-Reply-To: <20031006152632.GA3419@iram.es>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gabriel Paubert wrote:

>>> [...]
>>>>I am looking for a possibility to read out the last timestamp when an 
>>>>interrupt has occured.
>>>>[...]
> 
> 
> Doesn't the input layer add a timestamp to every event? 
> 
> At least that's the impression I have from xxd /dev/input/eventN: the
> first eight bytes of each 16 bytes packet look so furiously close to
> a struct timeval that they can't be anything else :-)
> 
> Just that I don't know how the devices and N are associated, it seems to be
> order of discovery/registering at boot.
Hello Gabriel,

Oh yes, - that looks quite good to me. I'm investigating on that now. I 
found out, that you need at least to compile the "evdev" module.

-Hans


