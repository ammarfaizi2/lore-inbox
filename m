Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318286AbSHUNkD>; Wed, 21 Aug 2002 09:40:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318288AbSHUNkC>; Wed, 21 Aug 2002 09:40:02 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:32494 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318286AbSHUNkB>; Wed, 21 Aug 2002 09:40:01 -0400
Subject: Re: 2.4.20-pre4 + LVM = hosed /proc/partitions
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: andersen@codepoet.org
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020821030430.GA11994@codepoet.org>
References: <20020821022732.GA11503@codepoet.org> 
	<20020821030430.GA11994@codepoet.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 21 Aug 2002 14:45:06 +0100
Message-Id: <1029937506.26411.29.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-08-21 at 04:04, Erik Andersen wrote:
> On Tue Aug 20, 2002 at 08:27:32PM -0600, Erik wrote:
> > Try compiling CONFIG_BLK_DEV_LVM into 2.4.20-pre4 and then run
> > 'cat /proc/partitions' for some amusement. I really like the way
> 
> It also seems to occur for md and ataraid.

Fixed in -ac for a while - not had time to do another sync with Marcelo
though

