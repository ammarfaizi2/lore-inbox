Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261242AbVDSPqN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbVDSPqN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 11:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261521AbVDSPqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 11:46:13 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:9900 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261242AbVDSPqL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 11:46:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=CmGeQthihE5TNe++AHOBAQuWm5mZ+naqQpN23gP/VNsQEfVOlrCEDncJeJ6h24erQokhsmVsO37pq3AEHQft3kRSRmJatc6fZ2Az7JnGOFJuZqXVjKcDeL+1AwNkiBXhvN8En4sbcTEjFG++IhoZ9Wa5ohTavaB8PVZ9x1T/k+o=
Message-ID: <875fe4a505041908466117acf4@mail.gmail.com>
Date: Tue, 19 Apr 2005 15:46:07 +0000
From: Francesco Oppedisano <francesco.oppedisano@gmail.com>
Reply-To: Francesco Oppedisano <francesco.oppedisano@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: more packets than interrupts
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
using tcpdump to capture ethernet packets i noticed i obtain more
packets than interrupts (taken from /proc/interrupts).
I found this with all NICs available to me (8139, e1000pro, one using
sk98lin, 3com 59x, via rhine etc..).
Where the NIC supports any type of mitigation or similar (see NAPI),
this function are disabled: so this happens with no mitigation
mechanisms.
How can this happen?
Can every driver manage many packets per call?

Thank you very much
Francesco
