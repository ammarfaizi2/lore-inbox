Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312582AbSDBNso>; Tue, 2 Apr 2002 08:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312706AbSDBNse>; Tue, 2 Apr 2002 08:48:34 -0500
Received: from APuteaux-101-2-1-180.abo.wanadoo.fr ([193.251.40.180]:23054
	"EHLO inet6.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S312582AbSDBNsT>; Tue, 2 Apr 2002 08:48:19 -0500
Date: Tue, 2 Apr 2002 15:47:37 +0200
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
To: Michal Dorocinski <zwierzak@venus.ci.uw.edu.pl>
Cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: sis 5591 ide in 2.4.19-pre3 consumes souls
Message-ID: <20020402154737.A2797@bouton.inet6-interne.fr>
Mail-Followup-To: Michal Dorocinski <zwierzak@venus.ci.uw.edu.pl>,
	linux-kernel@vger.kernel.org,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <3C9A0C22.3090702@inet6.fr> <20020321171851.A0D29A3C21@fancypants.trellisinc.com> <20020321182717.K806@venus.ci.uw.edu.pl> <20020402151757.B1182@venus.ci.uw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2002 at 03:17:57PM +0200, Michal Dorocinski wrote:
> Hello,
> 
> As I wrote I tryed 2.4.19-pre5 on my SIS motherboard nad 5513 IDE chipset and
> again I got the same problems. The -ac series of 2.4.19-pre4 is good and works
> fine.
> 

Marcelo, Alan, do you want me to provide a patch against pre5 or is the
latest sis5513 patch in AC's tree already scheduled for inclusion in Marcelo's
tree ?

Reminder: 2.4.19-pre5's sis5513.c holds 2 show-stoppers :
- incorrect SiS730 support,
- for most chipsets : lack of proper UDMA init if the BIOS doesn't setup
  UDMA itself.

The latest is the one bitting Michal IIRC.

LB.
