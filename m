Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262483AbTCRP6i>; Tue, 18 Mar 2003 10:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262486AbTCRP6i>; Tue, 18 Mar 2003 10:58:38 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:25770 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S262483AbTCRP6f>;
	Tue, 18 Mar 2003 10:58:35 -0500
Date: Tue, 18 Mar 2003 17:09:31 +0100
From: bert hubert <ahu@ds9a.nl>
To: netdev@oss.sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: interop success, ip6sec Linux 2.5.65 vs FreeBSD 4.7-STABLE
Message-ID: <20030318160931.GA9529@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>, netdev@oss.sgi.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to Niels Bakker I can report that stock Linux 2.5.65 can talk IP6SEC
with FreeBSD 4.7-STABLE (KAME 20010528/FreeBSD). It worked on the first try.

This using ipsec-tools-0.2.2 and manual keying. Racoon is reported not to
listen on IPv6 sockets yet, but we didn't try this.

The configuration used is that described in
http://lartc.org/howto/lartc.ipsec.html 'Intro with Manual Keying', with
IPv4 addresses replaced by IPv6 addresses.

Thanks for making this possible!

Regards,

Bert

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
http://netherlabs.nl                         Consulting
