Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964908AbWGHRCz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964908AbWGHRCz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 13:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964907AbWGHRCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 13:02:55 -0400
Received: from main.gmane.org ([80.91.229.2]:17861 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964901AbWGHRCz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 13:02:55 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Matthieu CASTET <castet.matthieu@free.fr>
Subject: Re: [RFC/PATCH] Introduce list_get() and list_get_tail()
Date: Sat, 08 Jul 2006 19:02:39 +0200
Message-ID: <pan.2006.07.08.17.02.38.345043@free.fr>
References: <200607080124.21856.dtor@insightbb.com> <p73wtaonqow.fsf@verdi.suse.de> <1152368186.3120.50.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cac94-1-81-57-151-96.fbx.proxad.net
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Sat, 08 Jul 2006 16:16:25 +0200, Arjan van de Ven a écrit :

> On Sat, 2006-07-08 at 15:58 +0200, Andi Kleen wrote:
>> Dmitry Torokhov <dtor@insightbb.com> writes:
>> 
>> > From: Dmitry Torokhov <dtor@mail.ru>
>> > 
>> > Add primitives to access first and last elements of a list instead
>> > of accessng pointers directly.
>> 
>> Wouldn't that be beter named list_first() and list_last() then?
>> _get is like _do and usually not very descriptive.
> 
> and _get tends to imply a reference count as well; I'm with Andi on
> this.. list_first() and list_last()
Yes from the name I would expect they remove the entry from the list...

