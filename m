Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932183AbVHRM55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbVHRM55 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 08:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbVHRM54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 08:57:56 -0400
Received: from mail17.syd.optusnet.com.au ([211.29.132.198]:50905 "EHLO
	mail17.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932183AbVHRM54 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 08:57:56 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Martin =?utf-8?q?MOKREJ=C5=A0?= <mmokrejs@ribosome.natur.cuni.cz>
Subject: Re: openafs is really faster on linux-2.4. than 2.6
Date: Thu, 18 Aug 2005 22:57:34 +1000
User-Agent: KMail/1.8.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <43032109.6030709@ribosome.natur.cuni.cz> <4304686F.20602@ribosome.natur.cuni.cz> <430483A2.9010605@ribosome.natur.cuni.cz>
In-Reply-To: <430483A2.9010605@ribosome.natur.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200508182257.35544.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Aug 2005 22:48, Martin MOKREJŠ wrote:
> I think the problem here is outside afs.
> Just doing this dd test but writing data directly to the ext2
> target gives same behaviour, i.e. on 2.4 kernel I see most of the
> CPU idle but on 2.6 kernel all that CPU amount is shown as in
> wait state. And the numbers from 2.4 kernel show higher throughput
> compared to the 2.6 kernel (regardless the the PREEMPT or no PREEMPT
> was used).

Don't forget to include sync time.

Con
