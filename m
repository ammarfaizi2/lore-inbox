Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759803AbWLFDNR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759803AbWLFDNR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 22:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759814AbWLFDNR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 22:13:17 -0500
Received: from wx-out-0506.google.com ([66.249.82.238]:15727 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759776AbWLFDNQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 22:13:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Gf96/6yuzpzJyAbolKJmWe2lIjeyiz8+ByHJUCRFX/xt6SzzlFWIcHcoVnMBUIA/maQhDiK/Xs0ck5UyR6adrwYn7HSQJUXRyWGwk5efQfQKcSjGeX6aarCjT2S/g/vxYm1MddR/YdP4J0iDASUKSL5EuPr1FxlkzGygwXDJy74=
Message-ID: <b3234d300612051913n2b1fefa8j125da6664594f0af@mail.gmail.com>
Date: Tue, 5 Dec 2006 21:13:15 -0600
From: "JAK anon" <jakk127@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re:can't boot : Spurious ACK with kernel 2.6.19
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Based on the email "xtables/iptables and atkbd.c Spurious ACK on
isa0060/serio0" from >jakk127@gmail.com I checked my configuration.
And yes, I have >CONFIG_NETFILTER_XTABLES=m and
CONFIG_IP_NF_IPTABLES=m as well.

>-- Bernd

If you try a recompile without xtables and iptables,will everything
work? I'm hoping the next patch will resolve this issue.
