Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbUBZXMb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 18:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261290AbUBZXIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 18:08:42 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:64762 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261253AbUBZXHx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 18:07:53 -0500
Message-ID: <403E7C40.9060603@mvista.com>
Date: Thu, 26 Feb 2004 15:07:44 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Jacobowitz <dan@debian.org>
CC: Tom Rini <trini@kernel.crashing.org>, Pavel Machek <pavel@suse.cz>,
       "Amit S. Kale" <amitkale@emsyssoft.com>, Pavel Machek <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>,
       KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>
Subject: Re: kgdb: rename i386-stub.c to kgdb.c
References: <20040224130650.GA9012@elf.ucw.cz> <200402251303.50102.amitkale@emsyssoft.com> <20040225103703.GB6206@atrey.karlin.mff.cuni.cz> <403D10DB.8060506@mvista.com> <20040225212826.GE1052@smtp.west.cox.net> <403D2230.8070000@mvista.com> <20040226042454.GA31771@nevyn.them.org>
In-Reply-To: <20040226042454.GA31771@nevyn.them.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Jacobowitz wrote:
> On Wed, Feb 25, 2004 at 02:31:12PM -0800, George Anzinger wrote:
> 
>>I would guess it is a problem in the emacs interface where one points at a 
>>location in the code window and enters a command to set a break point ( I 
>>think it is "^x " (control X space)).  It would appear that emacs then only 
>>sends the file name to gdb rather than the full path.
>>
>>This is not a show stopping problem, only confusing.  Once gdb figures out 
>>the right source, all is well.  I usually do it by setting a break point at 
>>the function by name, thus avoiding the point and grunt thing.
> 
> 
> This is a known problem in the emacs interfaces; it will be fixed, but
> I have no idea when the fixed version will be available :)
> 
I agree AND I have bigger fish to fry with emacs so....
-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

