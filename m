Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264319AbTICSmV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 14:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264278AbTICS3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 14:29:24 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:5581 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S264266AbTICS2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 14:28:43 -0400
Subject: Re: corruption with A7A266+200GB disk?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Cc: Erik Andersen <andersen@codepoet.org>, steveb@unix.lancs.ac.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0309031507040.6102-100000@logos.cnet>
References: <Pine.LNX.4.44.0309031507040.6102-100000@logos.cnet>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062613648.19982.22.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Wed, 03 Sep 2003 19:27:29 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-09-03 at 19:07, Marcelo Tosatti wrote:
> > Known problem.  For some reason Marcelo has not yet applied 
> > the fix for this problem to the 2.4.x kernels...
> 
> Alan (which has a clue about IDE unlike me) had complaints about your 
> approach, right? 

Bart pointed out the case in question can only occur when you move a
disk between interfaces physically. So the last IDE changes I sent you
included a minimal version of Erik's change

