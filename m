Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750931AbVLGMam@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750931AbVLGMam (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 07:30:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750935AbVLGMam
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 07:30:42 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:64493 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S1750922AbVLGMal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 07:30:41 -0500
Date: Wed, 7 Dec 2005 10:30:25 -0200
From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
To: Arjan van de Ven <arjan@infradead.org>
Cc: oliver@neukum.org, linux-usb-devel@lists.sourceforge.net,
       ehabkost@mandriva.com, gregkh@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: [PATCH 00/10] usb-serial: Switches from
 spin lock to atomic_t.
Message-Id: <20051207103025.7f4979a0.lcapitulino@mandriva.com.br>
In-Reply-To: <1133958433.2869.19.camel@laptopd505.fenrus.org>
References: <20051206095610.29def5e7.lcapitulino@mandriva.com.br>
	<20051206194041.GA22890@suse.de>
	<20051206201340.GB20451@duckman.conectiva>
	<200512062348.14349.oliver@neukum.org>
	<20051207102419.1f395664.lcapitulino@mandriva.com.br>
	<1133958433.2869.19.camel@laptopd505.fenrus.org>
Organization: Mandriva
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Dec 2005 13:27:13 +0100
Arjan van de Ven <arjan@infradead.org> wrote:

| 
| >  Isn't it right? Is the URB write so fast that switching to atomic_t
| > doesn't pay-off?
| 
| an atomic_t access and a spinlock are basically the same price... so
| what's the payoff ?

 One lock less, clean and less error prone code.

-- 
Luiz Fernando N. Capitulino
