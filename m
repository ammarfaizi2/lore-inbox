Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129511AbRDEXYM>; Thu, 5 Apr 2001 19:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129524AbRDEXYD>; Thu, 5 Apr 2001 19:24:03 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:62350 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S129511AbRDEXX7>;
	Thu, 5 Apr 2001 19:23:59 -0400
Message-ID: <3ACCFE60.FF896272@mandrakesoft.com>
Date: Thu, 05 Apr 2001 19:23:12 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: acc@CS.Stanford.EDU
Cc: linux-kernel@vger.kernel.org, mc@CS.Stanford.EDU
Subject: Re: [CHECKER] 15 potential pointer dereference errors in 2.4.3
In-Reply-To: <20010405015251.A20904@Xenon.Stanford.EDU>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Chou wrote:
> [BUG]
> /u2/acc/oses/linux/2.4.3/drivers/net/tokenring/tmsisa.c:274:tms_isa_probe: ERROR:NULL:273:274: Using
> unknown ptr "card" illegally! set by 'kmalloc':273

fixed


> [BUG]
> /u2/acc/oses/linux/2.4.3/drivers/pcmcia/rsrc_mgr.c:199:do_io_probe: ERROR:NULL:191:199: Using
> unknown ptr "b" illegally! set by 'kmalloc':191

fixed

-- 
Jeff Garzik       | Sam: "Mind if I drive?"
Building 1024     | Max: "Not if you don't mind me clawing at the dash
MandrakeSoft      |       and shrieking like a cheerleader."
