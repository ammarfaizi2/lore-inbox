Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751024AbWIVQKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024AbWIVQKs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 12:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751079AbWIVQKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 12:10:48 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:12751 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751024AbWIVQKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 12:10:47 -0400
Subject: Re: [PATCH 2.6.18] [TRIVIAL] Spelling fixes in
	Documentation/DocBook
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Michael Opdenacker <michael-lists@free-electrons.com>
Cc: linux-kernel@vger.kernel.org, trivial@kernel.org
In-Reply-To: <200609212318.07418.michael-lists@free-electrons.com>
References: <200609212318.07418.michael-lists@free-electrons.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 22 Sep 2006 17:34:33 +0100
Message-Id: <1158942873.24572.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-09-21 am 23:18 +0200, ysgrifennodd Michael Opdenacker:
> -<para>There's an <emphasis>ethernet</emphasis> gadget
> +<para>There's an <emphasis>Ethernet</emphasis> gadget

NAK, Ethernet is/was indeed a proper noun but it has become generic

> -and associated transciever to support <emphasis>Dual-Role</emphasis>
> +and associated transceiver to support <emphasis>Dual-Role</emphasis>

ACK

> -	value which selects the corresponding interrupt decription structure
> +	value which selects the corresponding interrupt description structure

ACK


>  	interrupt hardware and was therefore reimplemented with split
> -	functionality for egde/level/simple/percpu interrupts. This is not
> +	functionality for edge/level/simple/percpu interrupts. This is not

ACK - also per-cpu with hyphens ?

> -  <title>The Linux Journalling API</title>
> +  <title>The Linux Journaling API</title>

NAK. See previous multiple discussions.

>      The preferred method of initializing structures is to use
> -    designated initialisers, as defined by ISO C99, eg:
> +    designated initializers, as defined by ISO C99, eg:

NAK. Policy is to keep existing language usage not Americanize nor
Anglicize.

> -you hold the lock, noone can delete the object, so you don't need to
> +you hold the lock, no one can delete the object, so you don't need to

ACK


> -	support second drives on a port (such as SATA contollers) will
> +	support second drives on a port (such as SATA controllers) will
>  	use ata_noop_dev_select().

ACK


> -	Higher-level hooks, these two hooks can potentially supercede
> +	Higher-level hooks, these two hooks can potentially supersede

NAK - Supercede is correct

> -	ATA_QCFLAG_ACTIVE is clared from qc->flags.
> +	ATA_QCFLAG_ACTIVE is cleared from qc->flags.

ACK

> -        requirement during issuing or excution any ATA/ATAPI command.
> +        requirement during issuing or executing any ATA/ATAPI command.

NAK. Please check changes before submission

>          </para>
>  
>  	<itemizedlist>
> @@ -951,7 +951,7 @@ and other resources, etc.
>  
>          <listitem>
>  	<para>
> -	!BSY &amp;&amp; ERR after CDB tranfer starts but before the
> +	!BSY &amp;&amp; ERR after CDB transfer starts but before the

ACK

>          last byte of CDB is transferred.  ATA/ATAPI standard states



...

Please also submit each set of changes separately


