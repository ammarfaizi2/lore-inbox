Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261924AbVF0HBb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261924AbVF0HBb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 03:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261926AbVF0HBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 03:01:25 -0400
Received: from [195.33.99.129] ([195.33.99.129]:11853 "EHLO
	emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S261892AbVF0Gp7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 02:45:59 -0400
Message-Id: <42BFBCD4020000780001D7ED@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Mon, 27 Jun 2005 08:46:12 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: "Rik Riel" <riel@redhat.com>, "Keith Owens" <kaos@sgi.com>
Cc: "Christoph Lameter" <christoph@lameter.com>,
       "Clyde Griffin" <CGRIFFIN@novell.com>,
       "John W. Linville" <linville@tuxdriver.com>,
       "jmerkey" <jmerkey@utah-nac.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Novell Linux Kernel Debugger (NLKD)
References: <13706.1119601581@kao2.melbourne.sgi.com> <Pine.LNX.4.61.0506240801450.17151@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.61.0506240801450.17151@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Rik Van Riel <riel@redhat.com> 24.06.05 14:02:16 >>>
>On Fri, 24 Jun 2005, Keith Owens wrote:
>
>> Which is misleading.  There is some backtrace code, under F12, where it 
>> is called Stack Trace.
>
>It's using function keys?   Do those work over serial console?

It's not "the" debugger that's using function keys. The console frontend (one of the two currently available agents) is, the serial interface (the other available agent) obviously isn't, but that one doesn't know about keys at all. The console one in turn isn't intended to be run over a serial console...

Jan

