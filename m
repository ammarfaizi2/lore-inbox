Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262392AbSJVJoe>; Tue, 22 Oct 2002 05:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262395AbSJVJoe>; Tue, 22 Oct 2002 05:44:34 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:51383 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262392AbSJVJod>; Tue, 22 Oct 2002 05:44:33 -0400
Subject: Re: running 2.4.2 kernel under 4MB Ram
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Amol Kumar Lad <amolk@ishoni.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
In-Reply-To: <1035312869.2209.30.camel@amol.in.ishoni.com>
References: <1035312869.2209.30.camel@amol.in.ishoni.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 22 Oct 2002 11:06:43 +0100
Message-Id: <1035281203.31873.34.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-10-22 at 19:54, Amol Kumar Lad wrote:
> Hi,
>  I want to run 2.4.2 kernel on my embedded system that has only 4 Mb
> SDRAM . Is it possible ?? Is there any constraint for the minimum SDRAM
> requirement for linux 2.4.2

You want to run something a lot newer than 2.4.2. 2.4.19 will run on a
4Mb box, and with Rik's rmap vm seems to be run better than 2.2. That
will depend on the workload.

