Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262205AbVERPKz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262205AbVERPKz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 11:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262272AbVERPJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 11:09:35 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:26199 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262241AbVERPGe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 11:06:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nwtG9EWbmwpgSKLWaLJNZxqG40aX7esRKNhkPC3ec5+D1pjtEKKOBojNX4ecL+BDD17yGKS//2VmCZeJ9f0+DmeXE25AQ6AeVkZ4ZyB9HUODKacSo83WvzKFi4TuytloCELXkn82DEgFmqgIgrRRnNQmnF8wW3JsKu1M8yAZnaA=
Message-ID: <2cd57c900505180806669beab@mail.gmail.com>
Date: Wed, 18 May 2005 23:06:32 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: coywolf@lovecn.org
To: linux-kernel@vger.kernel.org
Subject: Re: Detecting link up
In-Reply-To: <20050518143712.GA21883@roonstrasse.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <428B1A60.6030505@inescporto.pt> <20050518134031.53a3243a@phoebee>
	 <20050518143712.GA21883@roonstrasse.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/18/05, Max Kellermann <max@duempel.org> wrote:
> On 2005/05/18 13:40, Martin Zwickel <martin.zwickel@technotrend.de> wrote:
> > On Wed, 18 May 2005 11:35:12 +0100
> > Filipe Abrantes <fla@inescporto.pt> bubbled:
> > > I need to detect when an interface (wired ethernet) has link up/down.
> > > Is  there a system signal which is sent when this happens? What is the
> > > best  way to this programatically?
> >
> > mii-tool?
> 
> A thought on a related topic:
> 
> When a NIC driver knows that there is no link, why does it even try to
> transmit a packet? It could return immediately with an error code,
> without applications having to wait for a timeout.
> 
> (I had a quick peek at two drivers, and they don't check the link
> status)

An NIC driver doesn't know if there's other links or not. One NIC
driver is for one type of NIC.  And there's also interface lo.
-- 
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
