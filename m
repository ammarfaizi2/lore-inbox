Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263862AbRFMOiE>; Wed, 13 Jun 2001 10:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263823AbRFMOhy>; Wed, 13 Jun 2001 10:37:54 -0400
Received: from firewall.ocs.com.au ([203.34.97.9]:64755 "EHLO ocs4.ocs-net")
	by vger.kernel.org with ESMTP id <S263799AbRFMOhj>;
	Wed, 13 Jun 2001 10:37:39 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "David S. Miller" <davem@redhat.com>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.6-pre3 unresolved symbol do_softirq 
In-Reply-To: Your message of "Wed, 13 Jun 2001 07:15:31 MST."
             <15143.30083.146128.113723@pizda.ninka.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 14 Jun 2001 00:37:23 +1000
Message-ID: <10620.992443043@ocs4.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jun 2001 07:15:31 -0700 (PDT), 
"David S. Miller" <davem@redhat.com> wrote:
>Surely this is a smaller hammer than making them all NOVERS(), I
>think all of these workarounds with novers for assembly are silly and
>are merely looking for a solution which nobody (perhaps except me :-)
>is bothering to look for.

modversions.h will disappear in 2.5 anyway, and be replaced with a
cleaner system of symbol versions which does not rely on pre-processor
fudging of symbol names.  It should be able to handle assembler as well
as C.

