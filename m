Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263526AbTLOMHI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 07:07:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263539AbTLOMHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 07:07:08 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:16653 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S263526AbTLOMHF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 07:07:05 -0500
Message-ID: <3FDDA686.6030502@aitel.hist.no>
Date: Mon, 15 Dec 2003 13:18:14 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: no, en
MIME-Version: 1.0
To: William Park <opengeometry@yahoo.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: Multiple keyboard/monitor vs linux-2.6?
References: <fa.da53dsa.dho216@ifi.uio.no> <20031212214310.GA744@node1.opengeometry.net> <20031213131405.GA11073@hh.idb.hist.no> <20031213211234.GB448@node1.opengeometry.net>
In-Reply-To: <20031213211234.GB448@node1.opengeometry.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Park wrote:
> On Sat, Dec 13, 2003 at 02:14:05PM +0100, Helge Hafting wrote:
[...]
>>I run my home machine this way:
>>2 standard keyboards, one connected to the keyboard port and
>>another connected to the ps2 mouse port.
> 
> 
> Plug PS/2 keyboard into PS/2 mouse port???  I didn't know you can do
> that.

The two ports are the same hardware, which makes sense as they
serve the same purpose - serial communication with a slow device.

The common case is one keyboard and one mouse, but two mice
or two keyboards works just as well as long as the software
expects it.  Linux 2.6 have no problems with this.

You need the ruby patch to use the two keyboards independently,
the standard kernel merges input from all attached keyboards into
one console.

You may attach a lot more keyboards using usb keyboards.

Helge Hafting


