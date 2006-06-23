Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752041AbWFWUm1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752041AbWFWUm1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 16:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752042AbWFWUm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 16:42:27 -0400
Received: from web33315.mail.mud.yahoo.com ([68.142.206.130]:25708 "HELO
	web33315.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1752041AbWFWUm0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 16:42:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=VuOvInhXm/cLMn+Kin/id5eOwapkimPYneNaniRmgLNcNKF50+7Xl4AzZJK0Rvcwkw0nsyCIrbfr+vlmLLR6MfKg5xkDoKsPxWzM7sNKFxKvmdd+bpWueWqA7CkINCwVZ+Sy+5GTxLjto6Ty0cl7J6JXNVESnv/dIO7F7kmSvMM=  ;
Message-ID: <20060623204226.91945.qmail@web33315.mail.mud.yahoo.com>
Date: Fri, 23 Jun 2006 13:42:26 -0700 (PDT)
From: Danial Thom <danial_thom@yahoo.com>
Reply-To: danial_thom@yahoo.com
Subject: Re: Measuring tools - top and interrupts
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060622173128.GD14682@harddisk-recovery.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Network traffic is usually IO bound, not CPU
> bound. The load figures
> top shows tell something about the amount of
> work the CPU has to do,
> not about how busy your PCI bus (or whatever
> bus the NIC lives on) is.
> 
> IIRC the networking layer in 2.6 differs quite
> a lot from 2.4, so the
> load average figures can be quite misleading.
> 

For the record, *most* of the work are I/O calls
(ie reading and writing registers), which are not
in the "background". I/O calls become more and
more expensive as the bus becomes saturated as it
takes longer to get the bus to do the operation. 

DT

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
