Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264214AbRFHQgQ>; Fri, 8 Jun 2001 12:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264204AbRFHQgG>; Fri, 8 Jun 2001 12:36:06 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:51728 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264215AbRFHQfz>; Fri, 8 Jun 2001 12:35:55 -0400
Subject: Re: 2.4.4 aic7xxx drivers unloads with open sg handles
To: jmerkey@vger.timpanogas.org (Jeff V. Merkey)
Date: Fri, 8 Jun 2001 17:33:55 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010607162625.A17709@vger.timpanogas.org> from "Jeff V. Merkey" at Jun 07, 2001 04:26:25 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E158PCt-0002sr-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am seeing the aic7xxx driver unload itself on 2.4.4 with sg 
> loaded and with a user space app holding active handles.  Subsequent
> closing and reopening of the /dev/sg0, etc. handles is not 
> causing a modprobe autoload of the driver, as normally happens
> after the code gets into this state.

Should be fine in 2.4.5-ac

