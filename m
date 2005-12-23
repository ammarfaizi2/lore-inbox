Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030396AbVLWHpP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030396AbVLWHpP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 02:45:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030429AbVLWHpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 02:45:15 -0500
Received: from xproxy.gmail.com ([66.249.82.205]:47070 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030396AbVLWHpN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 02:45:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rEt9GN7A9fWtrTTVdfRpslPosWOzu4NywpcHlZBc2tUawR4N69OjiW8P6B1BM0CHzdK9cXyzHRSeoUE4VKW0XXDiLkTpz2IyjBeqULBX1bMKqXYMF21sV4z0pfcONXvlx1cNN77K1WzifJMa3EV/VKqWQN5TWe+Tkb1GZrN1lbU=
Message-ID: <4807377b0512222345y517a8bb1l7edb324b9aba4edd@mail.gmail.com>
Date: Thu, 22 Dec 2005 23:45:10 -0800
From: Jesse Brandeburg <jesse.brandeburg@gmail.com>
To: rol@witbe.net
Subject: Re: [Linux 2.4.32] SATA ICH5/PIIX and Combined mode
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200512211140.jBLBeGD31936@tag.witbe.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1135164891.3456.11.camel@laptopd505.fenrus.org>
	 <200512211140.jBLBeGD31936@tag.witbe.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/05, Paul Rolland <rol@witbe.net> wrote:
> Well, the other way around is to upgrade e1000 driver in the 2.4.21EL-smp,
> as the machine I'm using is quite new, and RHES3 kernel can't find the
> Ethernet device, so the machine has no network.
> My first idea was to consider this as an opportunity to upgrade to the
> latest 2.4.x kernel, but reading you, this looks like a bad idea...
> 2.6.x would be better ?

the latest e1000-6.3.9 driver from http://sf.net/projects/e1000 should
work fine with that original 2.4 kernel and will definitely support
your new network hardware.

let us know how that goes
