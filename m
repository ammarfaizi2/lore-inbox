Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272110AbRH2WP5>; Wed, 29 Aug 2001 18:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272109AbRH2WPr>; Wed, 29 Aug 2001 18:15:47 -0400
Received: from mail.scsiguy.com ([63.229.232.106]:15378 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S272107AbRH2WPg>; Wed, 29 Aug 2001 18:15:36 -0400
Message-Id: <200108292215.f7TMFnY02699@aslan.scsiguy.com>
To: Matt <madmatt@bits.bris.ac.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Odd aic7xxx behaviour 
In-Reply-To: Your message of "Wed, 29 Aug 2001 16:57:59 BST."
             <Pine.LNX.4.21.0108291633080.4488-100000@bits.bris.ac.uk> 
Date: Wed, 29 Aug 2001 16:15:48 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi, could anyone help explain what is going on here?
>
>I've got an HP LH6000r with a built-in NetRaid/MegaRAID controller and
>also an Adaptec chip, a 7880U. In fact, here's the PCI listing:

Please run with "aic7xxx=verbose" set in your lilo.conf append line
(assumes statically linked driver) and send me the messages output
from the driver.  That should help me understand why the controller
is hanging.

--
Justin
