Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbUBKVtI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 16:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263388AbUBKVtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 16:49:08 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:1760 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261681AbUBKVtG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 16:49:06 -0500
Message-ID: <402AA2CE.2060104@nortelnetworks.com>
Date: Wed, 11 Feb 2004 16:46:54 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: =?ISO-8859-1?Q?M=E5ns=20Rullg=E5rd?= <mru@kth.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: printk and long long
References: <200402111604.49082.vda@port.imtp.ilyichevsk.odessa.ua> <Pine.LNX.4.44.0402111655170.17933-100000@gaia.cela.pl> <c0e0gr$mcv$1@terminus.zytor.com> <yw1xvfmdwe4s.fsf@kth.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Måns Rullgård wrote:

> What is the proper way to deal with printing an int64_t when int64_t
> can be either long or long long depending on machine?

Print it as long long, and even if there is an arch where that is 128 
bits it'll still work.

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

