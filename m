Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265447AbRFVPqc>; Fri, 22 Jun 2001 11:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265444AbRFVPqW>; Fri, 22 Jun 2001 11:46:22 -0400
Received: from f00f.stub.clear.net.nz ([203.167.224.51]:25604 "HELO
	metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S265447AbRFVPqN>; Fri, 22 Jun 2001 11:46:13 -0400
Date: Sat, 23 Jun 2001 03:46:06 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Matthias Welwarsky <matthias.welwarsky@frontsite.de>
Cc: Ben Greear <greearb@candelatech.com>,
        Guy Van Den Bergh <guy.vandenbergh@pandora.be>,
        linux-kernel@vger.kernel.org, Holger Kiehl <Holger.Kiehl@dwd.de>,
        "David S. Miller" <davem@redhat.com>,
        VLAN Mailing List <vlan@Scry.WANfear.com>,
        "vlan-devel (other)" <vlan-devel@lists.sourceforge.net>,
        Lennert <buytenh@gnu.org>, Gleb Natapov <gleb@nbase.co.il>
Subject: Re: [Vlan-devel] Should VLANs be devices or something else?
Message-ID: <20010623034606.B3732@metastasis.f00f.org>
In-Reply-To: <Pine.LNX.4.30.0106191016200.27487-100000@talentix.dwd.de> <3B2FCE0C.67715139@candelatech.com> <3B3270C4.3080103@pandora.be> <3B327B2A.26DBC2C4@candelatech.com> <3B335D8D.BBFFE309@frontsite.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B335D8D.BBFFE309@frontsite.de>; from matthias.welwarsky@frontsite.de on Fri, Jun 22, 2001 at 05:00:29PM +0200
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2001 at 05:00:29PM +0200, Matthias Welwarsky wrote:

    Can I use CBQ with VLans? It should be possible if they are
    devices, has anybody tried this yet?

Unless I horribly misunderstand things, anything you can do with a
standard ethernet interface without the presence of vlans, you should
be able to to on a vlan-interface in the presence of vlans.

So, yes, things like CBQ and bridging _should_ work. If they don't,
then arguably its a bug.



  --cw
