Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932647AbWCXOYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932647AbWCXOYo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 09:24:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932650AbWCXOYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 09:24:44 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:45341 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932647AbWCXOYo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 09:24:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PHr4G8X782Tk5deS9HkCRA3ApdM75Vw6RMKuYQRqSIuiNeOa/iprsZUEsRKWktS2ccc0Bs+qp5A2WV2+kYHi7a02zb3LUpYF2i9Yf+BY7KAAYgn+vQRYxTw6GY6n69qf0Hp6yf234/wcbHEITBmtDyNQMzPNuG+IET0KosqwMoc=
Message-ID: <4c4443230603240624g132b8d37t1a271a8303b810bf@mail.gmail.com>
Date: Fri, 24 Mar 2006 22:24:42 +0800
From: yang.y.yi@gmail.com
To: "Arjan van de Ven" <arjan@infradead.org>
Subject: Re: Connector: Filesystem Events Connector v3
Cc: LKML <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>,
       "Evgeniy Polyakov" <johnpol@2ka.mipt.ru>,
       "Matt Helsley" <matthltc@us.ibm.com>
In-Reply-To: <1143183541.2882.7.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4423673C.7000008@gmail.com>
	 <1143183541.2882.7.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/06, Arjan van de Ven <arjan@infradead.org> wrote:
>
> > It is also never redundant functionality of audit subsystem, if enable
> > audit option, audit subsystem will audit all the syscalls, so it adds
> > big overhead for the whole system,
>
> this is not true
Hmm, Why?
>
> > but Filesystem Event Connector just
> >  concerns those operations related to the filesystem, so it has little
> >  overhead, moreover, audit subsystem is a complicated function block,
> > it not only sends audit results to netlink interface, but also send
> > them to klog or syslog, so it will add big overhead. you can look File
> >  Event Connector as subset of audit subsystem, but File Event Connector
> >  is a very very lightweight subsystem.
>
> then make the syslog part optional.. if it's not already!
>
>
>
