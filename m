Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264888AbSKVOxF>; Fri, 22 Nov 2002 09:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264889AbSKVOxF>; Fri, 22 Nov 2002 09:53:05 -0500
Received: from mx1.elte.hu ([157.181.1.137]:25566 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S264888AbSKVOxE>;
	Fri, 22 Nov 2002 09:53:04 -0500
Date: Fri, 22 Nov 2002 16:00:11 +0100
From: KELEMEN Peter <fuji@elte.hu>
To: linux-kernel@vger.kernel.org
Subject: NFS performance ...
Message-ID: <20021122150010.GB18778@chiara.elte.hu>
Reply-To: KELEMEN Peter <fuji@elte.hu>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Organization: ELTE Eotvos Lorand University of Sciences, Budapest, Hungary
X-GPG-KeyID: 1024D/EE4C26E8 2000-03-20
X-GPG-Fingerprint: D402 4AF3 7488 165B CC34  4147 7F0C D922 EE4C 26E8
X-PGP-KeyID: 1024/45F83E45 1998/04/04
X-PGP-Fingerprint: 26 87 63 4B 07 28 1F AD  6D AA B5 8A D6 03 0F BF
X-Comment: Personal opinion.  Paragraphs might have been reformatted.
X-Copyright: Forwarding or publishing without permission is prohibited.
X-Accept-Language: hu,en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a very simple NFS setup over a siwtched 100Mbit/s network.

client is Celeron 400MHz/256M RAM, using XFS
server is dual Pentium Pro 200MHz/1G RAM, using XFS
server is running Linux 2.4.19-pre8aa3.

Network bandwith can be utilized, because ICMP flooding the
server results in ~20000 kbit/s network traffic (as of
iptraf), but NFS (v3,udp) write performance is unacceptably
slow (around 300 KiB/sec), same results with the following
kernels:
Linux 2.4.18-WOLK3.1
Linux 2.4.18-wolk3.7.1
Linux 2.4.20-pre8aa2

However, with 2.4.19-rmap14b-xfs the very same NFS
performance tops out at 2.54 MiB/sec.  What's the catch?

TIA,
Peter

-- 
    .+'''+.         .+'''+.         .+'''+.         .+'''+.         .+''
 Kelemen Péter     /       \       /       \       /      fuji@elte.hu
.+'         `+...+'         `+...+'         `+...+'         `+...+'
