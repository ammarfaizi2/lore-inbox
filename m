Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267681AbUI3Gn2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267681AbUI3Gn2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 02:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268900AbUI3Gn2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 02:43:28 -0400
Received: from smtp805.mail.sc5.yahoo.com ([66.163.168.184]:56930 "HELO
	smtp805.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267681AbUI3Gn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 02:43:26 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH 7/8] Psmouse - add packet size
Date: Thu, 30 Sep 2004 01:43:23 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200409290140.53350.dtor_core@ameritech.net> <200409290824.59004.dtor_core@ameritech.net> <20040929133859.GA3896@ucw.cz>
In-Reply-To: <20040929133859.GA3896@ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409300143.23582.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 29 September 2004 08:38 am, Vojtech Pavlik wrote:
> Well, I understand your point, but I still think it's worth keeping the
> return values consistent with the rest of the probe routines, because if
> not, THEN you (or some other reader) would get used to the
> positive-style returns with the protocol detection routines and
> definitely understand it wrong elsewhere.
> 

Vojtech,

I converted the -detect routines to return -1 on failure and implemented the
other change you have requested. Please do:

	bk pull bk://dtor.bkbits.net/input

Thanks!

-- 
Dmitry
