Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290502AbSA3TtG>; Wed, 30 Jan 2002 14:49:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290014AbSA3Ts4>; Wed, 30 Jan 2002 14:48:56 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:17113 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S290521AbSA3Tss>;
	Wed, 30 Jan 2002 14:48:48 -0500
Date: Wed, 30 Jan 2002 14:48:47 -0500
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Kent E Yoder <yoder1@us.ibm.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IBM Lanstreamer bugfixes
Message-ID: <20020130144847.C1391@havoc.gtf.org>
In-Reply-To: <OF0323731B.AAE52C6B-ON85256B51.005748CD@raleigh.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <OF0323731B.AAE52C6B-ON85256B51.005748CD@raleigh.ibm.com>; from yoder1@us.ibm.com on Wed, Jan 30, 2002 at 01:27:29PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 01:27:29PM -0600, Kent E Yoder wrote:
> Is this the best way to make sure the PCI cache is flushed for writes that 
> need to happen immediately?

Pretty much...

> I don't see many other drivers doing it...

Some drivers don't need or do things in other ways, some need it and
don't have it...

If you wanted to audit and test long driver delays in various random
the world will cheer your name, I'm sure ;-) ;-)

	Jeff

