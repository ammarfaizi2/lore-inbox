Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265970AbUGEJcW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265970AbUGEJcW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 05:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265972AbUGEJcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 05:32:22 -0400
Received: from mailout09.sul.t-online.com ([194.25.134.84]:31975 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id S265970AbUGEJcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 05:32:21 -0400
Message-Id: <5.1.0.14.2.20040705112716.025fbb98@pop.t-online.de>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 05 Jul 2004 11:32:21 +0200
To: linux-kernel@vger.kernel.org
From: margitsw@t-online.de (Margit Schubert-While)
Subject: Re: [PATCH] prism54 use set_pci_mwi()
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Seen: false
X-ID: GiJoJZZXrehZm0M6C05n8rs471xJMjGe62KwvjMnoUAmeT6vcypUwh
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven scribeth :
 > pci_set_mwi() has a return value that you're supposed to check.....
Don't need to. Either it doesn't support MWI or the device will not
accept the new cache line size. In either case nothing changes and
as far as the driver is concerned this is not an error.
(Incidentally neither do the e1000, starfire, tulip,typhoon drivers)

Margit


