Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289096AbSBDRJO>; Mon, 4 Feb 2002 12:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289108AbSBDRJC>; Mon, 4 Feb 2002 12:09:02 -0500
Received: from smtp01ffm.de.uu.net ([192.76.144.150]:54072 "EHLO
	smtp01ffm.de.uu.net") by vger.kernel.org with ESMTP
	id <S289096AbSBDRIr> convert rfc822-to-8bit; Mon, 4 Feb 2002 12:08:47 -0500
Content-Type: text/plain; charset=US-ASCII
From: Tobias Wollgam <tobias.wollgam@materna.de>
Organization: Materna GmbH
To: linux-kernel@vger.kernel.org
Subject: Re: UNDI/PXE for 2.4.x available?
Date: Mon, 4 Feb 2002 18:08:43 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020204154633.E2BC267F3@penelope.materna.de> <a3md05$ps3$1@cesium.transmeta.com>
In-Reply-To: <a3md05$ps3$1@cesium.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
X-Encoded: Changed encoding from 8bit for 7bit transmission
Message-Id: <20020204170844.2AB5667F1@penelope.materna.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We want to install PCs over ethernet with PXE. For the first boot from 
net we have nothing than the network, we don't know the hardware, so an 
UNDI in the kernel would be perfect. IMHO

> I think you'll have that problem with any UNDI driver; in either case
> I suspect that (a) performance will stink no matter what 

That's ok for the things we will do.

> and (b) it won't work properly with SMP unless you apply really
> heavy locking.

Does it matter in our case?
 
> The PXE people at Intel really seems enamored with the idea of using
> the UNDI stack all the way into the operating system; 

We need it not to run an operating system, we need it for the 
installation of an operating system.


On the other hand, UNDI will deliver a network driver for all PXE-cards 
that come up before there is any direct hardware support. (Ok, then b 
matters)

-- 
Tobias Wollgam * Softwaredevelopment * Business Unit Information 
MATERNA GmbH Information & Communications
Vosskuhle 37 * 44141 Dortmund  
http://www.materna.de
