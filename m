Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261605AbUJ0C5H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbUJ0C5H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 22:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261611AbUJ0C5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 22:57:07 -0400
Received: from smtp809.mail.sc5.yahoo.com ([66.163.168.188]:51094 "HELO
	smtp809.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261605AbUJ0C46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 22:56:58 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Stelian Pop <stelian@popies.net>
Subject: Re: [PATCH 0/5] Sonypi driver model & PM changes
Date: Tue, 26 Oct 2004 21:56:50 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>, Vojtech Pavlik <vojtech@suse.cz>
References: <20041026155639.42445.qmail@web81306.mail.yahoo.com> <20041026180932.GA17655@deep-space-9.dsnet>
In-Reply-To: <20041026180932.GA17655@deep-space-9.dsnet>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410262156.52832.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 26 October 2004 01:09 pm, Stelian Pop wrote:
> > Btw, you should probably drop conditional support for input layer
> > and always compile it in.
> 
> Is CONFIG_INPUT now a requirement for the (at least i386) kernel ?
> If this is the case, I'll drop the conditional. 
> 

While it can be disabled when one selects !EMBEDDED I doubt hi/she will
be interested in sonnypi in this case :). For all practical reasons input
layer is always present.

-- 
Dmitry
