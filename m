Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267776AbUJOOQc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267776AbUJOOQc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 10:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267798AbUJOOQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 10:16:32 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:13007 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267777AbUJOOQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 10:16:28 -0400
Subject: Re: waiting on a condition
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Martijn Sipkema <martijn@entmoot.nl>
Cc: "Peter W. Morreale" <morreale@radiantdata.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1097701123.4648.13.camel@localhost.localdomain>
References: <02bb01c4b138$8a786f10$161b14ac@boromir>
	 <416D49FF.10003@radiantdata.com>
	 <1097701123.4648.13.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1097846028.9855.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 15 Oct 2004 14:13:51 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-10-13 at 21:58, Martijn Sipkema wrote:
> wait_event() seems to be what I was looking for; I don't really like the
> condition being an argument.

If you look at how it unwraps it is quite hard to do any other way.
You can always pass   myfunction() as the condition which is what I do
in for example the new tty code.


