Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964959AbWILHsv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964959AbWILHsv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 03:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964968AbWILHsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 03:48:51 -0400
Received: from gw.goop.org ([64.81.55.164]:38883 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S964959AbWILHsu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 03:48:50 -0400
Message-ID: <4506665D.2090001@goop.org>
Date: Tue, 12 Sep 2006 00:48:45 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060907)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: akpm@osdl.org, ak@suse.de, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: i386 PDA patches use of %gs
References: <1158046540.2992.5.camel@laptopd505.fenrus.org>
In-Reply-To: <1158046540.2992.5.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> Jeremy, is there a reason you're specifically using %gs and not %fs? If
> not, would you mind a switch to using %fs instead?
>   

The main reason for using %gs was to take advantage of gcc's TLS 
support.  I intend to measure the cost of gs vs fs, and if there's a 
significant difference I'll switch.

    J
