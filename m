Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264174AbUFAJgb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264174AbUFAJgb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 05:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264961AbUFAJgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 05:36:31 -0400
Received: from lindsey.linux-systeme.com ([62.241.33.80]:40974 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S264174AbUFAJg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 05:36:29 -0400
From: Marc-Christian Petersen <m.c.p@kernel.linux-systeme.com>
Organization: Linux-Systeme GmbH
To: linux-kernel@vger.kernel.org, orders@nodivisions.com
Subject: Re: swappiness ignored
Date: Tue, 1 Jun 2004 11:36:17 +0200
User-Agent: KMail/1.6.2
References: <40B43B5F.8070208@nodivisions.com> <200405260940.i4Q9eJdS000767@81-2-122-30.bradfords.org.uk> <40BC2EFA.6090503@nodivisions.com>
In-Reply-To: <40BC2EFA.6090503@nodivisions.com>
X-Operating-System: Linux 2.6.5-wolk3.0 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200406011136.17055@WOLK>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 June 2004 09:23, Anthony DiSante wrote:

Hi Anthony,

> In the "why swap at all" thread, there was mention of the
> /proc/sys/vm/swappiness tunable, and some people suggested echoing a zero
> to there if you want to minimize/disable swap usage, or echoing a 100 to
> maximize swap usage, etc.
> But on my 2.6.5 system, I can echo a zero to there, then cat it back to
> make sure... then 30 seconds later cat it again, and it's been changed to
> something else (50, 60, 80something).
> Is this supposed to be a value that can be manually adjusted, as some have
> claimed, or is it something the kernel manages automatically?  I definitely
> can't manually set it without having it overwritten shortly thereafter.

I bet you have /proc/sys/vm/autoswappiness or the previous version of it 
w/o /proc stuff.

ciao, Marc
