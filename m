Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318177AbSGQBYE>; Tue, 16 Jul 2002 21:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318182AbSGQBYD>; Tue, 16 Jul 2002 21:24:03 -0400
Received: from host.greatconnect.com ([209.239.40.135]:33554 "EHLO
	host.greatconnect.com") by vger.kernel.org with ESMTP
	id <S318177AbSGQBYC>; Tue, 16 Jul 2002 21:24:02 -0400
Subject: Re: Lost Interrupt
From: Samuel Flory <sflory@rackable.com>
To: David Gironella Casademont <giro@hades.udg.es>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0207161657430.28172-100000@hades.udg.es>
References: <Pine.LNX.4.30.0207161657430.28172-100000@hades.udg.es>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 16 Jul 2002 18:27:45 -0700
Message-Id: <1026869266.2294.2857.camel@flory.corp.rackablelabs.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Try Alan's ac kernel for the promise controllers.  It seems to work
for most people.
ftp://ftp.us.kernel.org/pub/kernel/linux/kernel/people/alan/linux-2.4/2.4.19/


PS- You will need to patch 2.4.19-rc1 1st.
ftp://ftp.us.kernel.org/pub/kernel/linux/kernel/v2.4/testing/

cd (kernel source for 2.4.18)
bzcat |patch-2.4.19-rc1.bz2 |patch -p 1
bzcat |patch-2.4.19-rc1-ac4.bz2 |patch -p 1

On Tue, 2002-07-16 at 07:58, David Gironella Casademont wrote:
> 
> I compile 2.4.18 kernel with promise raid support, and when kernel is
> checking my partitions say: Lost interrupt
> 
> any idea.
> 
> thk
> Giro
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


