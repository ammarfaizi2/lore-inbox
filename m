Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135964AbRD0Axi>; Thu, 26 Apr 2001 20:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135965AbRD0Ax2>; Thu, 26 Apr 2001 20:53:28 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:25868 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S135964AbRD0AxR>; Thu, 26 Apr 2001 20:53:17 -0400
Date: Fri, 27 Apr 2001 02:53:15 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.4.4-pre7 build failure w/ IP NAT and ipchains
Message-ID: <20010427025315.A25473@burns.dt.e-technik.uni-dortmund.de>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

net/network.o: In function `ip_nat_setup_info':
net/network.o(.text+0x37b3e): undefined reference to `helpers'
net/network.o(.text+0x37b54): undefined reference to `helpers'

.config bzip2'ed:

begin 644 .config.bz2
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
=S;JJ8;KI>F!O/D!F.']P0#,'^+N2*<*$@0*1X%@`
`
end

-- 
Matthias Andree
