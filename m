Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261619AbSIYXzy>; Wed, 25 Sep 2002 19:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261637AbSIYXzy>; Wed, 25 Sep 2002 19:55:54 -0400
Received: from mx.spiritone.com ([216.99.221.5]:49936 "HELO mx.spiritone.com")
	by vger.kernel.org with SMTP id <S261619AbSIYXzx>;
	Wed, 25 Sep 2002 19:55:53 -0400
Date: 25 Sep 2002 17:06:53 -0700
Message-ID: <3D924F9D.C2DCF56A@us.ibm.com>
From: "Nivedita Singhvi" <niv@us.ibm.com>
To: davem@redhat.com
Cc: linux-kernel@vger.kernel.org
X-Mailer: Mozilla 4.78 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
Subject: Re: [ANNOUNCE] NF-HIPAC: High Performance Packet Classification
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Such a scheme can even obviate socket lookup if implemented properly.
> It'd basically be a flow cache, much like route lookups but with an
> expanded key set and the capability to stack routes.  Such a flow
> cache could even be two level, with the top level being %100 cpu local
> on SMP (ie. no shared cache lines).

...

> Everything, from packet forwarding, to firewalling, to TCP socket
> packet receive, can be described with routes.  It doesn't make sense
> for forwarding, TCP, netfilter, and encapsulation schemes to duplicate
> all of this table lookup logic and in fact it's entirely superfluous.

Are you saying combine the tables themselves? 

One of the tradeoffs would be serialization of the access, then,
right? i.e. Much less stuff could happen in parallel? Or am I 
completely misunderstanding your proposal?

> This stackable routes idea being worked on, watch this space over the
> next couple of weeks :-)

thanks,
Nivedita
