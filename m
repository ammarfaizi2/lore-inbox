Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281140AbRKKWlx>; Sun, 11 Nov 2001 17:41:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281146AbRKKWln>; Sun, 11 Nov 2001 17:41:43 -0500
Received: from d040.dhcp212-198-181.noos.fr ([212.198.181.40]:53379 "EHLO
	rousalka.dyndns.org") by vger.kernel.org with ESMTP
	id <S281140AbRKKWlg> convert rfc822-to-8bit; Sun, 11 Nov 2001 17:41:36 -0500
Subject: Iptables & ECN
From: Nicolas Mailhot <Nicolas.Mailhot@LaPoste.net>
To: linux-kernel@vger.kernel.org
Cc: netfilter@lists.samba.org, alan@lxorguk.ukuu.org.uk
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/0.99.0 (Preview Release)
Date: 11 Nov 2001 23:41:33 +0100
Message-Id: <1005518494.5895.0.camel@rousalka.dyndns.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[ Please CC me any replies as I'm not on the list ]

	I'm afraid I've just run in an embarassing iptables « bug » on
2.4.13-ac7. When I tell iptables to drop unclean packets with ecn on I
can no longuer connect to ftp.kernel.org, and get a lot of ipt_unclean:
TCP reserved bits not zero in the logs. Shouldn't iptables be made
ecn-aware ? (especially given all the red-inked comments on ECN in the
FAQ)

	Regards,

-- 
Nicolas

