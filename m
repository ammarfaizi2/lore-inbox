Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965036AbWCULMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965036AbWCULMN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 06:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965034AbWCULMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 06:12:12 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:45487 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965036AbWCULML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 06:12:11 -0500
Subject: Re: Accessing kernel information from a module
From: Arjan van de Ven <arjan@infradead.org>
To: Anand SVR <anand.svr@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <48a4d13c0603210302h3eb23f12v1bdf3c51c8f9b711@mail.gmail.com>
References: <48a4d13c0603210302h3eb23f12v1bdf3c51c8f9b711@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 21 Mar 2006 12:12:08 +0100
Message-Id: <1142939529.3077.57.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-21 at 16:32 +0530, Anand SVR wrote:
> Hi,
> 
> I am in the process of writing a module that collects kernel
> information of various kernel subsytems and pass this on to a remote
> monitoring/management node. The information could be statistical data
> maintained in data structures of memory, process, network and so on. 
> Or it could be any kernel variables that are of interest.

you forgot to attach your source code ;)

> Is there a way of accessing proc information from the module ?

eh why on earth is your code in the kernel then? Shouldn't your code be
in userspace if you want to send such information to a remote system???


