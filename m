Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318224AbSGWVO3>; Tue, 23 Jul 2002 17:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318225AbSGWVO3>; Tue, 23 Jul 2002 17:14:29 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:37108 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318224AbSGWVO2>; Tue, 23 Jul 2002 17:14:28 -0400
Subject: Re: Handling NMI in a kernel module
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Isabelle, Francois" <Francois.Isabelle@ca.kontron.com>
Cc: "Linux-Ha (E-mail)" <linux-ha@muc.de>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <5009AD9521A8D41198EE00805F85F18F219A7E@sembo111.teknor.com>
References: <5009AD9521A8D41198EE00805F85F18F219A7E@sembo111.teknor.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 23 Jul 2002 23:30:30 +0100
Message-Id: <1027463430.32299.145.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-07-23 at 18:37, Isabelle, Francois wrote:
> I'ld like my driver to register a callback there, what about maintaining a
> list of user callback functions which could be registered via:
>  
> request_nmi(int option, void (*hander)(void *dev_id, struct pt_regs *regs),
> unsigned long flags, const char *dev_name, void *dev_id)

Doesnt seen unreasonable
;
> Is there any standard mecanism to implement such features( dual stage
> watchdog ) ?

We have a watchdog API but not yet dual stage stuff. Its becoming a must
have for HA stuff so the API needs extending

