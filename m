Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268254AbUIBL7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268254AbUIBL7a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 07:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268263AbUIBL7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 07:59:30 -0400
Received: from the-village.bc.nu ([81.2.110.252]:62093 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268254AbUIBL73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 07:59:29 -0400
Subject: Re: Weird Problem with TCP
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rohit Neupane <rohitneupane@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <93e09f0104090202216403c08d@mail.gmail.com>
References: <93e09f0104090202216403c08d@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094122617.4966.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 02 Sep 2004 11:56:59 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> * Everything works fine for about 5-10 mins then all of a sudden TCP services
> are not accessable.
> * For some reason TCP times out. However at the same time ping,traceroute and
> dns trace works without any problem.
> * The connected TCP sokets keeps working without any problem. I verified this
> by using Msn chat. I observerd that I chat session ( which I had started
> when everything was normal) continued without any problem however I was not
> able to initiate a new chat session.

Are you using session tracking. The symptoms you describe are
classically those of session tracking nat/firewalling/whatever running
out of table entries and being unable to allow new connections.

