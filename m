Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261975AbUKVIC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261975AbUKVIC7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 03:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261981AbUKVIC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 03:02:59 -0500
Received: from hermine.aitel.hist.no ([158.38.50.15]:64267 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S261984AbUKVIAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 03:00:52 -0500
Message-ID: <41A19E44.9080005@hist.no>
Date: Mon, 22 Nov 2004 09:07:32 +0100
From: Helge Hafting <helge.hafting@hist.no>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tomas Carnecky <tom@dbservice.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel thoughts of a Linux user
References: <200411181859.27722.gjwucherpfennig@gmx.net> <419CFF73.3010407@dbservice.com>
In-Reply-To: <419CFF73.3010407@dbservice.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Carnecky wrote:

> Gerold J. Wucherpfennig wrote:
> > - Replace DRI with sth. slimmer and intoduce real kernel drivers
>
>> and introduce real kernel drivers which handel all the initialization 
>> and interrupt handling (only minimal hardware abstraction). One goal 
>> is to
>> remove X.org's PCI magic. Ultimately this shall give framebuffer and X
>> the same basis. This was summarized on kerneltrap.org.
>
>
> Is it possible to have two or more 'workstations' on one computer?

Yes - thats what the "ruby" kernel patch is all about.  I have a computer
with two "workstations" at home.  Compared to two computers, it
saves space, power, parts,  and above all - administrative work.  Only one
machine to upgrade, secure, configure.

> A 'workstation' is a monitor, keyboard, mouse etc. tied together and
> represents a place where someone can work.
> I know it's possible to do this using a Xserver (running two Xservers on
> different virtual consoles, each with its own
> configuration/keyboard/mouse/monitor), but I'd like to realise it more
> low-level, on the level of virtual terminals, so that each 'workstation'
> would have it's own 'Ctrl+F1', 'Ctrl+F2' etc.

Sure - ruby gives you that.  X may need a patch in order to support
ctrl+F2... on the scond keyboard, as the second console uses vt numbers
from 17 to 32.

>
> Background:
> Today, you can buy video cards with two connectors for monitors, or even
> put two of those cards into one mainboard, making it possible to connect
> four monitors to one computer. A P4 HT enabled CPU would be enough for
> four office workers who edit text documents, unless they aren't playing
> games :) So you could cut costs by buying one set of Mainboard/CPU/RAM
> and then for every worker just a monitor/keyboard/mouse.
> Places like internet-cafes could profit, they usually have many same
> computers side by side, each with the same configuration, but on many no
> one is working, they just run and consume energy. 

Yes, you can do that.   The limit seems to be how many monitors you can
connect - there seems to be no practical limit to how many USB keyboards
& mice you can use.  The lengt of wires might also be a problem
with more than four.

Helge Hafting
