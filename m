Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261466AbUKBVOM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261466AbUKBVOM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 16:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261470AbUKBVJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 16:09:41 -0500
Received: from relay01.roc.ny.frontiernet.net ([66.133.131.34]:5610 "EHLO
	relay01.roc.ny.frontiernet.net") by vger.kernel.org with ESMTP
	id S261468AbUKBVJP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 16:09:15 -0500
From: Russell Miller <rmiller@duskglow.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: question on common error-handling idiom
Date: Tue, 2 Nov 2004 16:12:28 -0500
User-Agent: KMail/1.7
Cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
References: <4187E920.1070302@nortelnetworks.com> <Pine.LNX.4.53.0411022154210.28980@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.53.0411022154210.28980@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200411021512.29155.rmiller@duskglow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 November 2004 14:58, Jan Engelhardt wrote:

> So to summarize, it's done to reduce code whilst keeping the error code
> around until we actually leave the function.
>
I understand what you're saying, the OP did raise a point that I think is 
worth repeating, that it's an extra instruction in all but error cases.  Is 
that extra instruction worth the tradeoff?

--Russell

>
> My € 0.02!
>
>
> Jan Engelhardt

-- 

Russell Miller - rmiller@duskglow.com - Le Mars, IA
Duskglow Consulting - Helping companies just like you to succeed for ~ 10 yrs.
http://www.duskglow.com - 712-546-5886
