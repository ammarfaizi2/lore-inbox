Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262250AbVD1Ti6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262250AbVD1Ti6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 15:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262251AbVD1Ti5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 15:38:57 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:41201 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262250AbVD1Ti4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 15:38:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=siMPJi1Sw1bd0V5dtbgdED0c4S9MyfonelRTWtUuGk7j5b2hSKaa9BsL2ileIXGxI7kivD2OM4+UoHU1DOo0IAsDpeUJjfJmEmXLF7bGLNhDbrFm/9qVlrGFEjlna9Tg/KNlFijaCPLkMvZRa1tTjsQdxTqmZl95MD50ZjvlfNU=
Message-ID: <d4757e6005042812382bd77376@mail.gmail.com>
Date: Thu, 28 Apr 2005 15:38:55 -0400
From: Joe <joecool1029@gmail.com>
Reply-To: Joe <joecool1029@gmail.com>
To: Denis Vlasenko <vda@ilport.com.ua>, Greg KH <greg@kroah.com>
Subject: Re: Device Node Issues with recent mm's and udev
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <200504280940.15277.vda@ilport.com.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <d4757e6005042716523af66bae@mail.gmail.com>
	 <20050427170106.782ea4c3.akpm@osdl.org>
	 <d4757e600504271715493fd507@mail.gmail.com>
	 <200504280940.15277.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Interesting.. this appears to be a completley different issue also
now.  sdb1 is a free space partition (type 0 in fdisk).  Well
apparently that doesn't appear with the new mm's and this is the
source of all my problems.

So I was mistaken about it being overwritten I think... this is a
little more different then I thought.

I use dd if=my_sw.bin of=/dev/sdb1 to copy the image over.. but as the
sdb1 node isn't being created.. its just sending it to a file.  I'll
continue to look more at it now.

Thanks,

Joe
