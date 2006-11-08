Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422768AbWKHT7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422768AbWKHT7Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 14:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422764AbWKHT7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 14:59:23 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:9621 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1422768AbWKHT7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 14:59:22 -0500
X-Sasl-enc: z7muBsVCoN3SrIhC9SbUKZcuPE8xMXSQgJOGk8gd+XEh 1163015962
Date: Wed, 8 Nov 2006 17:59:15 -0200
From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
To: Michael Holzheu <HOLZHEU@de.ibm.com>
Cc: Ingo Oeser <ioe-lkml@rameria.de>, linux-kernel@vger.kernel.org,
       mschwid2@de.ibm.com, pavel@ucw.cz
Subject: Re: How to document dimension units for virtual files?
Message-ID: <20061108195915.GD15063@khazad-dum.debian.net>
References: <20061108180154.GC15063@khazad-dum.debian.net> <OFAE836F2F.99AEEBE4-ON41257220.0065E716-41257220.006655A4@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFAE836F2F.99AEEBE4-ON41257220.0065E716-41257220.006655A4@de.ibm.com>
X-GPG-Fingerprint: 1024D/1CDB0FE3 5422 5C61 F6B7 06FB 7E04  3738 EE25 DE3F 1CDB 0FE3
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Nov 2006, Michael Holzheu wrote:
> > Please consider using ":" to separate units and other specific
> > qualifiers (e.g. led colors) from the main attribute name.  This helps
> > userspace applications to behave better when faced with stuff like
> > "a_b_c:unit1"
> and
> > "a_b_c:unit2" at the same time.
> 
> ":" is probably not a good idea.  I think it is treated by the bash as a
> special character. Try:

We could use some other char (but in that case, it is best to change what
the led sysfs class is doing, they are already using ":", and that's why I
suggested ":").  As long as it is not "_"...

That said, is it just a problem for the bash completion or does it *really*
process the : to be something else?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
