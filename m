Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271729AbTHHR1g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 13:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271733AbTHHR1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 13:27:35 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:17801 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S271729AbTHHR1e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 13:27:34 -0400
Subject: Re: 2.4.22-rc1 FIFO bug still present
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rob van Nieuwkerk <robn@verdi.et.tudelft.nl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>, sct@redhat.com
In-Reply-To: <20030808145444.388dc9e6.robn@verdi.et.tudelft.nl>
References: <20030806192306.6085b3e0.robn@verdi.et.tudelft.nl>
	 <1060346384.4933.34.camel@dhcp22.swansea.linux.org.uk>
	 <20030808145444.388dc9e6.robn@verdi.et.tudelft.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1060363405.4938.60.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 08 Aug 2003 18:23:25 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-08-08 at 13:54, Rob van Nieuwkerk wrote:
> How does this other bug present itself ?
> I use both console and serial port output in my readonly CF
> application.  And I don't have any writes to the CF anymore after
> fixing the FIFO bug.

create a tty device node
open it
delete it
mount the fs r/o or unmount it
close it



