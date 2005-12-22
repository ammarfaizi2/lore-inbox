Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030285AbVLVTEt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030285AbVLVTEt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 14:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030289AbVLVTEt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 14:04:49 -0500
Received: from webmail.univie.ac.at ([131.130.1.47]:53239 "EHLO
	webmail1.univie.ac.at") by vger.kernel.org with ESMTP
	id S1030285AbVLVTEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 14:04:49 -0500
Message-ID: <1386.81.217.14.229.1135278280.squirrel@webmail.univie.ac.at>
In-Reply-To: <20051222183012.GA27353@buici.com>
References: <200512221352.23393.axel.kernel@kittenberger.net>
    <20051222173704.GB23411@buici.com>
    <1167.81.217.14.229.1135275158.squirrel@webmail.univie.ac.at>
    <20051222183012.GA27353@buici.com>
Date: Thu, 22 Dec 2005 20:04:40 +0100 (CET)
Subject: Re: Possible Bootloader Optimization in inflate (get rid of 
     unnecessary 32k Window)
From: "Axel Kittenberger" <axel.kittenberger@univie.ac.at>
To: "Marc Singer" <elf@buici.com>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.5
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Right.  And the time to perform that one copy is exactly...?
>
> I doubt that it is a significant percentage of the whole operation.

Well Yes I agree, I guess also it isn't. Its roughly the time you need to
copy 1 MB memory around. I just noticed that it is in fact after all still
unneccary and that in fact could be optimized away. As some
window-management could can be optimized away.

I would volunteer to take the time to code it, but only if i have a good
feeling that it would be accepted... if not, well than okay for me also, i
will do other things :o)

Greetings, Axel

