Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269752AbUJALMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269752AbUJALMF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 07:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269754AbUJALMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 07:12:05 -0400
Received: from pc1.pod.cz ([213.155.230.51]:17030 "HELO pc11.op.pod.cz")
	by vger.kernel.org with SMTP id S269752AbUJALMD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 07:12:03 -0400
From: "Vitezslav Samel" <samel@mail.cz>
Date: Fri, 1 Oct 2004 13:12:01 +0200
To: Harald Welte <laforge@netfilter.org>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: [BUG] active ftp doesn't work since 2.6.9-rc1
Message-ID: <20041001111201.GA23033@pc11.op.pod.cz>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi!

  After upgrade to 2.6.9-rc3 on the firewall (with NAT), active ftp stopped
working. The first kernel, which doesn't work is 2.6.9-rc1.
Sympotms: passive ftp works O.K., active FTP doesn't open data stream (and in
logs there entries about invalid packets - using
iptables ... -m state --state INVALID -j LOG)

  If you need any extra data point, mail me.

	Cheers,
		Vita Samel
