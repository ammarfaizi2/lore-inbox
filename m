Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292557AbSBZSLL>; Tue, 26 Feb 2002 13:11:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292612AbSBZSLB>; Tue, 26 Feb 2002 13:11:01 -0500
Received: from ns1.alcove-solutions.com ([212.155.209.139]:1968 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S292557AbSBZSKx>; Tue, 26 Feb 2002 13:10:53 -0500
Date: Tue, 26 Feb 2002 19:10:51 +0100
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Daniel Shane <daniel.shane@eicon.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PCI driver in userspace
Message-ID: <20020226181051.GA8007@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
In-Reply-To: <D8E12241B029D411A3A300805FE6A2B9025761AB@montreal.eicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D8E12241B029D411A3A300805FE6A2B9025761AB@montreal.eicon.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2002 at 12:42:26PM -0500, Daniel Shane wrote:

> I think this is a good example to start with. It has all the
> interresting features. I hope it also has interrupt handling
> to userspace (by generating SIGIO's). 

It hasn't, it just continually polls the I/O ports for 
completition.

> Although I dont know if this is a good idea in the first place.

I think it depends on the interrupt frequency, and other things.

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
