Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270680AbTHORhU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 13:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270682AbTHORhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 13:37:20 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:7435 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S270680AbTHORhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 13:37:19 -0400
Message-ID: <3F3D1DDC.9040500@techsource.com>
Date: Fri, 15 Aug 2003 13:52:28 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
CC: "'Willy Tarreau'" <willy@w.ods.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: generic strncpy - off-by-one error
References: <D069C7355C6E314B85CF36761C40F9A42E20B6@mailse02.se.axis.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Peter Kjellerstedt wrote:

> Timothy's       3.125003    6.128571    9.147905   33.325337  


Which of mine did you test?  The one with the single-byte fill, or the 
one with the multiple fill loops that does words for the bulk of the fills?

With some minor tweaks to eliminate compiler stupidity which compares 
against -1, that might win on the fill phase.  No?


