Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755231AbWKMQ6R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755231AbWKMQ6R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 11:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755230AbWKMQ6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 11:58:15 -0500
Received: from ref.nmedia.net ([66.39.177.2]:60849 "EHLO ref.nmedia.net")
	by vger.kernel.org with ESMTP id S1755229AbWKMQ5u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 11:57:50 -0500
Date: Mon, 13 Nov 2006 08:57:48 -0800 (PST)
From: Shaun Q <shaun@c-think.com>
X-X-Sender: shaun@ref.nmedia.net
To: Arjan van de Ven <arjan@infradead.org>
cc: Jesper Juhl <jesper.juhl@gmail.com>,
       Stephen Clark <Stephen.Clark@seclark.us>, linux-kernel@vger.kernel.org
Subject: Re: Dual cores on Core2Duo not detected?
In-Reply-To: <1163435248.15249.179.camel@laptopd505.fenrus.org>
Message-ID: <Pine.BSO.4.64.0611130857280.660@ref.nmedia.net>
References: <Pine.BSO.4.64.0611122322060.30536@ref.nmedia.net> 
 <4558773A.4040803@seclark.us>  <Pine.BSO.4.64.0611130752270.21533@ref.nmedia.net>
  <9a8748490611130803o4dbd05a5w6d271136db5e4378@mail.gmail.com> 
 <Pine.BSO.4.64.0611130804011.21533@ref.nmedia.net>
 <1163435248.15249.179.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 13 Nov 2006, Arjan van de Ven wrote:

>> Processor #0 6:15 APIC version 20
>> Setting APIC routing to physical flat
>> BIOS bug, no explicit IRQ entries, using default mptable. (tell your hw
>> vendor)
>
> hmmm smells like a disabled ACPI, since normally this info comes from
> ACPI nowadays, not the mptable
>
>
>
>
> if you want to mail me at work (you don't), use arjan (at) linux.intel.com
> Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org
>
>
That was indeed the problem.  Thanks guys! :)

Shaun
