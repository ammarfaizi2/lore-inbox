Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136459AbREDRVV>; Fri, 4 May 2001 13:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136465AbREDRVL>; Fri, 4 May 2001 13:21:11 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:48855 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S136459AbREDRU7>;
	Fri, 4 May 2001 13:20:59 -0400
Message-ID: <3AF2E4F1.6C5BE7FC@mandrakesoft.com>
Date: Fri, 04 May 2001 13:20:49 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Adam <adam@vbfx.com>, linux-kernel@vger.kernel.org,
        "Michael K. Johnson" <johnsonm@redhat.com>
Subject: Re: dhcp problem with realtek 8139 clone with rh 7.1
In-Reply-To: <E14vj1d-0007es-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > I've had the same problem with the 8139too drivers and DHCP.  The reason
> > I figure it must be the drivers is because in the 2.4.3 kernel, I'm able
> > to use the 8139too drivers with DHCP without any problems.  In 2.4.4 it
> > locks my system.
> 
> Multiple such reports - seems the 8139too update broke stuf - any ideas Jeff,
> should I revert to the 2.4.3 one ?

I would say if Monday comes by without hearing from me, yes. It fixes
some people, breaks others :/

I've already got a fix on the dhcp breakage -- need to lock and unlock
EEprom before setting certain registers, and I am working on the other
problem (symptom: 'partner ability 0000' even when a link is present).

-- 
Jeff Garzik      | Game called on account of naked chick
Building 1024    |
MandrakeSoft     |
