Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261900AbVBITFm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261900AbVBITFm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 14:05:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbVBITFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 14:05:42 -0500
Received: from hera.cwi.nl ([192.16.191.8]:19627 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261900AbVBITFg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 14:05:36 -0500
Date: Wed, 9 Feb 2005 20:05:25 +0100
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Andries Brouwer <Andries.Brouwer@cwi.nl>, Jirka Bohac <jbohac@suse.cz>,
       lkml <linux-kernel@vger.kernel.org>, roman@augan.com, hch@nl.linux.org
Subject: Re: [rfc] keytables - the new keycode->keysym mapping
Message-ID: <20050209190517.GA15005@apps.cwi.nl>
References: <20050209132654.GB8343@dwarf.suse.cz> <20050209152740.GD12100@apps.cwi.nl> <20050209160345.GA16487@ucw.cz> <20050209163856.GH12100@apps.cwi.nl> <20050209165500.GB16670@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050209165500.GB16670@ucw.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2005 at 05:55:00PM +0100, Vojtech Pavlik wrote:
> On Wed, Feb 09, 2005 at 05:38:56PM +0100, Andries Brouwer wrote:
>> On Wed, Feb 09, 2005 at 05:03:45PM +0100, Vojtech Pavlik wrote:
>> 
>>>> It seems very unlikely that you cannot handle Czech with all
>>>> combinations of 8 keys pressed, and need 9.
>>> 
>>> A czech keyboard has the letters 'escrzyaie' with accents on the number
>>> row of keys. With a Shift, they are supposed to produce the original
>>> numbers, but with a CapsLock, they're supposed to produce the uppercase.
>>> With a right alt or one of three czech dead keys they should produce
>>> the !@#$%^&*() symbols.
>>> 
>>> It's kind of logical, kind of stupid, but anyway it's the national standard.
>>> 
>>> You can't do that currently. The main problem is that CapsLock is
>>> hardcoded to work as a Shift on keys and you can't make it work
>>> differently for normal letter keys and for the upper row of keys.
>> 
>> I think the fallacy in that reasoning is the idea that the key
>> labeled CapsLock has to be bound to the kernel function named capslock.
>  
> How do you make it control the CapsLock LED then?

OK - I agree. The keyboard can do what you want,
but there is no independent CapsLock LED control.

Andries


[not that I think the proposed change is a good idea,
but now I understand why one would want to extend functionality]
