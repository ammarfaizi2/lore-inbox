Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751355AbVHNAWk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbVHNAWk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 20:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbVHNAWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 20:22:39 -0400
Received: from [81.2.110.250] ([81.2.110.250]:24218 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751355AbVHNAWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 20:22:38 -0400
Subject: Re: Opening of blocking FIFOs not reliable?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Teemu Koponen <tkoponen@iki.fi>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <c10854018590b2287bc64888d842a4ac@iki.fi>
References: <c10854018590b2287bc64888d842a4ac@iki.fi>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 14 Aug 2005 01:49:24 +0100
Message-Id: <1123980565.14138.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-08-12 at 20:18 -0700, Teemu Koponen wrote: 
> the reader gets scheduled. Shouldn't the writer's open() block until 
> the reader's open() is done?

Not neccessarily - but you are correct that it should lead to the
readers open completing and then EOFs being returned. Do you have a test
case for the problem?

Alan
