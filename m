Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932150AbVKLFuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbVKLFuY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 00:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbVKLFuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 00:50:24 -0500
Received: from twin.uoregon.edu ([128.223.214.27]:40151 "EHLO twin.uoregon.edu")
	by vger.kernel.org with ESMTP id S932150AbVKLFuY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 00:50:24 -0500
Date: Fri, 11 Nov 2005 21:50:01 -0800 (PST)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: joelja@twin.uoregon.edu
To: Marc Perkel <marc@perkel.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 939 pin Opteron vs. Athlon 64? What's the difference?
In-Reply-To: <43753726.8060205@perkel.com>
Message-ID: <Pine.LNX.4.64.0511112146330.13416@twin.uoregon.edu>
References: <43753726.8060205@perkel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Nov 2005, Marc Perkel wrote:

> OK - I'm confused. What is the difference between an Athlon 64 and a 939 pin 
> Opteron? Or the difference between a 939 pin dual core Athlon and a 939 pin 
> dual core opteron?
>
> I understand that the 940 pin Opterons can be used on multiple processor 
> boards. But I just don't get it about using a single opteron.

939 uses unregistered memory and 940 uses registered. There are 
differences in various cores, 90nm vs 130nm. 512k vs 1mb cache, dual vs 
single core, number of cache coherrent hyper-transport links etc, but 
memory is the key difference for the socket.

> Also - while I'm asking - AMD Semprtons now are 64 bit - so what's the 
> difference between a 64 bit Sempton and a 64 Bit athlon?
>
>

-- 
--------------------------------------------------------------------------
Joel Jaeggli  	       Unix Consulting 	       joelja@darkwing.uoregon.edu
GPG Key Fingerprint:     5C6E 0104 BAF0 40B0 5BD3 C38B F000 35AB B67F 56B2

