Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932329AbWEOMIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbWEOMIu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 08:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbWEOMIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 08:08:50 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:8408 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751417AbWEOMIt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 08:08:49 -0400
Date: Mon, 15 May 2006 14:08:35 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Srinivas G." <srinivasg@esntechnologies.co.in>
cc: linux-kernel-Mailing-list <linux-kernel@vger.kernel.org>,
       Fawad Lateef <fawadlateef@gmail.com>, jjoy@novell.com,
       "Nutan C." <nutanc@esntechnologies.co.in>,
       "Mukund JB." <mukundjb@esntechnologies.co.in>, gauravd.chd@gmail.com,
       bulb@ucw.cz, greg@kroah.com, Shakthi Kannan <cyborg4k@yahoo.com>
Subject: Re: GPL and NON GPL version modules
In-Reply-To: <AF63F67E8D577C4390B25443CBE3B9F70928DE@esnmail.esntechnologies.co.in>
Message-ID: <Pine.LNX.4.61.0605151406100.6005@yvahk01.tjqt.qr>
References: <AF63F67E8D577C4390B25443CBE3B9F70928DE@esnmail.esntechnologies.co.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>If I have a module called module A which uses the GPL code and module B
>uses the NON GPL (proprietary) code. If the module A depends on module
>B, is it possible to load these modules?
>
Technically yes.

>Will it be violating any GPL Rules?
>

	[ big IANAL sticker ]

More or less. If my understanding of the GPL is correct, the "combined" 
thing (the kernel machinery, as in: the contents of your RAM) becomes GPL. 
But since proprietary code involved, it's gets a hell lot more complicated, 
since, obviously, you can't just GPLize proprietary code of others.



Jan Engelhardt
-- 
