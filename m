Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261698AbUKCQch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261698AbUKCQch (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 11:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261699AbUKCQch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 11:32:37 -0500
Received: from c7ns3.center7.com ([216.250.142.14]:54940 "EHLO
	smtp.slc03.viawest.net") by vger.kernel.org with ESMTP
	id S261698AbUKCQcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 11:32:21 -0500
Message-ID: <41890D5F.4000006@drdos.com>
Date: Wed, 03 Nov 2004 09:54:55 -0700
From: "Jeff V. Merkey" <jmerkey@drdos.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Jeff Garzik <jgarzik@pobox.com>, Brad Campbell <brad@wasp.net.au>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: nfs stale filehandle issues with 2.6.10-rc1 in-kernel server
References: <41877751.502@wasp.net.au>	 <1099413424.7582.5.camel@lade.trondhjem.org> <4187E4E1.5080304@pobox.com>	 <4187F69E.9020604@drdos.com> <1099431477.7854.21.camel@lade.trondhjem.org>	 <20041102225304.GA11441@galt.devicelogics.com> <41882414.2070003@drdos.com> <1099444402.9957.8.camel@lade.trondhjem.org>
In-Reply-To: <1099444402.9957.8.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:

>ty den 02.11.2004 Klokka 17:19 (-0700) skreiv Jeff V. Merkey:
>
>  
>
>>>Connect 2.4.18 and 2.6.9 with NFS 3 enabled.  I am seeing problems 
>>>connecting and file size mismatches.  I also see errors with zero
>>>length files (host side) that get opened and populated with data
>>>and the remote side is unable to read them -- keeps seeing 
>>>them as zero length.  
>>>      
>>>
>
>That's entirely expected. NFS has always been forced to use a polling
>model for attribute cache consistency. "man 5 nfs" and read all about
>the "actimeo" mount options that control this behaviour.
>
>Cheers,
>  Trond
>
>  
>
Trond,

Thanks for the update.  I noticed from another post on this thread that 
the problems with
/etc/exports are being addressed.  This was the other problem I was 
seeing but it appears
to be getting fixed.

Jeff


