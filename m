Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129482AbQLCGR5>; Sun, 3 Dec 2000 01:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129657AbQLCGRr>; Sun, 3 Dec 2000 01:17:47 -0500
Received: from a203-167-249-89.reverse.clear.net.nz ([203.167.249.89]:18948
	"HELO metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S129482AbQLCGRm>; Sun, 3 Dec 2000 01:17:42 -0500
Date: Sun, 3 Dec 2000 18:47:12 +1300
From: Chris Wedgwood <cw@f00f.org>
To: Philip Blundell <philb@gnu.org>
Cc: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>,
        Donald Becker <becker@scyld.com>, Francois Romieu <romieu@cogenit.fr>,
        Russell King <rmk@arm.linux.org.uk>, Ivan Passos <lists@cyclades.com>,
        linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [RFC] Configuring synchronous interfaces in Linux
Message-ID: <20001203184712.C1630@metastasis.f00f.org>
In-Reply-To: <Pine.LNX.3.96.1001202130202.1450B-100000@mandrakesoft.mandrakesoft.com> <jgarzik@mandrakesoft.mandrakesoft.com> <E142IrA-0007hG-00@kings-cross.london.uk.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E142IrA-0007hG-00@kings-cross.london.uk.eu.org>; from philb@gnu.org on Sat, Dec 02, 2000 at 08:02:00PM +0000
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does it? At which point? To me it looks like it calls dev->do_ioctl
or am I missing something?


  --cw


On Sat, Dec 02, 2000 at 08:02:00PM +0000, Philip Blundell wrote:
    >Does 'ifconfig eth0 media xxx' wind up calling dev->set_config?
    
    Yes.
    
    p.
    
    
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
