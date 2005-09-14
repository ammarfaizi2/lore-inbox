Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965115AbVINJfo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965115AbVINJfo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 05:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965114AbVINJfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 05:35:44 -0400
Received: from mail12.syd.optusnet.com.au ([211.29.132.193]:13288 "EHLO
	mail12.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S965115AbVINJfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 05:35:43 -0400
From: Con Kolivas <kernel@kolivas.org>
To: manz@intes.de
Subject: Re: Another 2.6.13-ck3 locks machine after some time, 2.6.12.5 work fine
Date: Wed, 14 Sep 2005 19:35:19 +1000
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <200509141125.00971.manz@intes.de>
In-Reply-To: <200509141125.00971.manz@intes.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509141935.19749.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Sep 2005 19:25, Hartmut Manz wrote:
> I have also tried to switch to kernel 2.6.13-ck3 and after about 2 hours
> the machine is completely frozen. I have than applied the proposed patch
> from Linus for a simmilar problem on 2.6.13.1 but it didn't help.

-ck currently has a unique problem with 250HZ as well. Try 1000 if you are 
using 250.

Cheers,
Con
