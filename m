Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132050AbQLHWzU>; Fri, 8 Dec 2000 17:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132049AbQLHWzC>; Fri, 8 Dec 2000 17:55:02 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:3282 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S131803AbQLHWy4>;
	Fri, 8 Dec 2000 17:54:56 -0500
Date: Fri, 8 Dec 2000 14:24:27 -0800
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S . Miller" <davem@redhat.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: GlobeCom 2000 -> Networking papers
Message-ID: <20001208142427.C26305@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,

	I was a GlobeCom 2 weeks ago, and I noticed a few articles
relevant to Linux networking that you might be interested in
reading...

On ECN :
------
	Archan Misra, John Baras & Teunis Ott. Generalised TCP
Congestion Avoidance and its Effect on Bandwidth Sharing and
Variability. GlobeCom 2000 (GI2b-2).
	The response to an ECN by the end node should not be as
drastic as to a packet loss (divide window by two) to make traffic
smoother. Can't find paper on the web, but they have the full PhD
Dissertation :
		http://www.isr.umd.edu/TechReports/CSHCN/2000/CSHCN_PhD_2000-1/CSHCN_PhD_2000-1.pdf

	Srisankar Kunniyur & R. Srikant. A Decentralised Adaptive ECN
Marking Algorithm.
	How to optiomally mark packets with ECN in the routers. Good,
but fail to address cohexistence problem (mix of ECN and non ECN
traffic). Available at :
		http://www.comm.csl.uiuc.edu/~kunniyur/research.html

On Header compression :
---------------------
	Lars-Ake Larzon, Hans Hannu, Lars-Erik Jonsson, Krister
Svanbro. Efficient Transport of Voice over IP over Cellular Links.
	Describes ROCCO, a RTP robust header compression scheme. No
paper available, but the IETF working group has more recent work :
		http://www.ietf.org/ids.by.wg/rohc.html

	My personal comment : It would be nice if someone would allow
the use of those header compression schemes (ROCCO as well as regular
VJ) over regular Ethernet adapters and not only within PPP.
	The reason is that IP over IrDA (IrLAN) and IP over BlueTooth
(PAN) use Ethernet encapsulation, and don't use PPP. 802.11 and other
wireless LANs use regular Ethernet frames natively. All those
technologies, due to their low bandwidth, could make good use of it...

	Have fun...

	Jean
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
