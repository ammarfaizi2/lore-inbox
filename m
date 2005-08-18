Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750890AbVHRMsj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbVHRMsj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 08:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750904AbVHRMsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 08:48:39 -0400
Received: from r3az252.chello.upc.cz ([213.220.243.252]:8064 "EHLO
	aquarius.doma") by vger.kernel.org with ESMTP id S1750890AbVHRMsi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 08:48:38 -0400
Message-ID: <430483A2.9010605@ribosome.natur.cuni.cz>
Date: Thu, 18 Aug 2005 14:48:34 +0200
From: =?windows-1252?Q?Martin_MOKREJ=8A?= 
	<mmokrejs@ribosome.natur.cuni.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050815
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: openafs is really faster on linux-2.4. than 2.6
References: <43032109.6030709@ribosome.natur.cuni.cz> <4303293D.10805@ribosome.natur.cuni.cz> <430339AF.7080102@ribosome.natur.cuni.cz> <4303B70B.9080707@ribosome.natur.cuni.cz> <4304686F.20602@ribosome.natur.cuni.cz>
In-Reply-To: <4304686F.20602@ribosome.natur.cuni.cz>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think the problem here is outside afs.
Just doing this dd test but writing data directly to the ext2
target gives same behaviour, i.e. on 2.4 kernel I see most of the
CPU idle but on 2.6 kernel all that CPU amount is shown as in
wait state. And the numbers from 2.4 kernel show higher throughput
compared to the 2.6 kernel (regardless the the PREEMPT or no PREEMPT
was used).
M.
