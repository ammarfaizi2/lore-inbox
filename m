Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262129AbVBPXgC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbVBPXgC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 18:36:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbVBPXgC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 18:36:02 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:55253 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262126AbVBPXfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 18:35:55 -0500
From: Parag Warudkar <kernel-stuff@comcast.net>
To: Pedro Venda <pjvenda@arrakis.dhis.org>
Subject: Re: possible leak in kernel 2.6.10-ac12
Date: Wed, 16 Feb 2005 18:35:25 -0500
User-Agent: KMail/1.7.92
Cc: LKML <linux-kernel@vger.kernel.org>
References: <4213D70F.20104@arrakis.dhis.org>
In-Reply-To: <4213D70F.20104@arrakis.dhis.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502161835.26047.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 16 February 2005 06:28 pm, Pedro Venda wrote:
> Having upgraded most of them to 2.6.10-ac12, one of them showed a linear
> growth of used memory over the last 7 days, after the first 2.6.10-ac12
> boot. It came to a point that it started swapping and the swap usage too
> started to grow linearly.

cat /proc/slabinfo please. I am also seeing similar symptoms (although that is 
with 2.6.11-rc4 there is a possibility of a common bug) here and I seem to 
have linearly growing size-64 in slabinfo.

Parag
