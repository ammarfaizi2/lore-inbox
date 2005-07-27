Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262270AbVG0CkJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262270AbVG0CkJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 22:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262169AbVG0CkI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 22:40:08 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:31451 "EHLO
	pd4mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S262355AbVG0CkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 22:40:02 -0400
Date: Tue, 26 Jul 2005 20:34:10 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Weird USB errors on HD
In-reply-to: <4s66H-2ai-19@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <42E6F2A2.7060405@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <4s3BX-8X-7@gated-at.bofh.it> <4s66H-2ai-21@gated-at.bofh.it>
 <4s66H-2ai-19@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karim Yaghmour wrote:
> That being said, shouldn't there be a way for the kernel to refuse to
> use this hd if it's not getting enough power. I don't know enough about
> USB to say, but isn't there something more elegant that could be done in
> software?

Not really.. It seems like pretty much a matter of the controller saying 
  it can supply so much power, the drive says it uses so much power, but 
one of them is lying and the drive ends up tripping the overcurrent.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

