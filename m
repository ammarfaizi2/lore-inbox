Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264490AbTFKVjp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 17:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264494AbTFKVjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 17:39:45 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:33665 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264490AbTFKVjn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 17:39:43 -0400
Content-Type: text/plain;
  charset="iso-8859-15"
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM xSeries Linux Solutions
To: Mika =?iso-8859-15?q?Penttil=E4?= <mika.penttila@kolumbus.fi>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
Subject: Re: [PATCH 2/2][2.5]Unisys ES7000 platform subarch
Date: Wed, 11 Jun 2003 14:52:24 -0700
User-Agent: KMail/1.4.3
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <3FAD1088D4556046AEC48D80B47B478C022BDA75@usslc-exch-4.slc.unisys.com> <3EE75144.4030300@kolumbus.fi>
In-Reply-To: <3EE75144.4030300@kolumbus.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200306111452.24518.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 11 June 2003 08:56 am, Mika Penttilä wrote:
> Just out of curiosity, what are "Physical Cluster" and "Logical
> Cluster"?  This terminology doesn't appear in Intel documentation.
> AFAIK, IPIs are currently always sent using logical destination mode,
> and in your patch ioapic entries have logical mode in cluster case. So
> where does physical cluster  come into play?
>
> --Mika

Starting with P4s, Intel has enabled physical interrupts that correctly use 
the upper nibble of the destination field when clustered addressing mode is 
turned on.  Hence the name "Physical Cluster", even if it may not be official 
terminology.

-- 
James Cleverdon
IBM xSeries Linux Solutions
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot com

