Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262938AbUKRUFN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262938AbUKRUFN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 15:05:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261158AbUKRUDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 15:03:06 -0500
Received: from neopsis.com ([213.239.204.14]:65005 "EHLO
	matterhorn.neopsis.com") by vger.kernel.org with ESMTP
	id S261157AbUKRUA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 15:00:58 -0500
Message-ID: <419CFF73.3010407@dbservice.com>
Date: Thu, 18 Nov 2004 21:00:51 +0100
From: Tomas Carnecky <tom@dbservice.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel thoughts of a Linux user
References: <200411181859.27722.gjwucherpfennig@gmx.net>
In-Reply-To: <200411181859.27722.gjwucherpfennig@gmx.net>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Neopsis-MailScanner-Information: Please contact the ISP for more information
X-Neopsis-MailScanner: Found to be clean
X-MailScanner-From: tom@dbservice.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerold J. Wucherpfennig wrote:
 > - Replace DRI with sth. slimmer and intoduce real kernel drivers
> and introduce real kernel drivers which handel all the initialization and 
> interrupt handling (only minimal hardware abstraction). One goal is to
> remove X.org's PCI magic. Ultimately this shall give framebuffer and X
> the same basis. This was summarized on kerneltrap.org.

Is it possible to have two or more 'workstations' on one computer?
A 'workstation' is a monitor, keyboard, mouse etc. tied together and
represents a place where someone can work.
I know it's possible to do this using a Xserver (running two Xservers on
different virtual consoles, each with its own
configuration/keyboard/mouse/monitor), but I'd like to realise it more
low-level, on the level of virtual terminals, so that each 'workstation'
would have it's own 'Ctrl+F1', 'Ctrl+F2' etc.

Background:
Today, you can buy video cards with two connectors for monitors, or even
put two of those cards into one mainboard, making it possible to connect
four monitors to one computer. A P4 HT enabled CPU would be enough for
four office workers who edit text documents, unless they aren't playing
games :) So you could cut costs by buying one set of Mainboard/CPU/RAM
and then for every worker just a monitor/keyboard/mouse.
Places like internet-cafes could profit, they usually have many same
computers side by side, each with the same configuration, but on many no
one is working, they just run and consume energy.

tom

