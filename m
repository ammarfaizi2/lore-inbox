Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265496AbTIJS5R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 14:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265499AbTIJS4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 14:56:47 -0400
Received: from h-66-167-103-234.CHCGILGM.covad.net ([66.167.103.234]:27147
	"EHLO mail1.taskperformance.net") by vger.kernel.org with ESMTP
	id S265496AbTIJSzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 14:55:12 -0400
Message-ID: <45804.208.195.70.41.1063216488.squirrel@fw.taskperformance.com>
In-Reply-To: <200309101311.20196.dtor_core@ameritech.net>
References: <3F5F0F2C.5080407@fawad.net>
    <200309101311.20196.dtor_core@ameritech.net>
Date: Wed, 10 Sep 2003 12:54:48 -0500 (CDT)
Subject: Re: Linksys connectivity problem using 2.6.0-test4
From: "Fawad Halim" <fawad@fawad.net>
To: "Dmitry Torokhov" <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry, Thanks for the pointer. In 2.6, apparently ECN is enabled by
default. Disabling it did the trick.

-fawad

> On Wednesday 10 September 2003 06:46 am, Fawad Halim wrote:
>> Hi,
>>     I'm having trouble connecting to the http based admin ports on my
>> LinkSys VPN router (BEFVP41) using the 2.6.0-test4 kernel on Redhat 9.
>> The connectivity works fine with 2.4.20-19.9 from Redhat as well as
>> other 2.4.x kernels. With the 2.6 kernel, I can ping the machine, but
>> can't connect to the http ports (80, 8080)
>>
> <skip>
>> # telnet 192.168.3.1 80
>> Trying 192.168.3.1...
>> telnet: connect to address 192.168.3.1: Connection refused
>>
>> The VPN router is doing NAT correctly for both kernels, and connectivity
>> to services other than the router itself is fine.
>>
>
> Make sure that you not using ECN - my Linksys refuses incoming
> connections with ECN. Passes them tohrough just fine, tough.
>
> Dmitry
>

