Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261278AbVC2SB6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261278AbVC2SB6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 13:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261284AbVC2SB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 13:01:58 -0500
Received: from rproxy.gmail.com ([64.233.170.198]:56163 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261278AbVC2SB4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 13:01:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=boXeHW0oeACWzpSGROiLUVpgKziS7mvaAi/cw6BlPqmZXpQ8Bgw8eD+bEuNcukVPRqoEVBUj+P/KomzTBeDl/1ZfQiEirGpbvyuTkYHqVAx1e0dT0cXjNgXXJUy2gJn2U4zajgUVk+Tr3+2fo8NyBOrRupT81TzmCwEgQIFLjC0=
Message-ID: <aec8d6fc050329095549143eb6@mail.gmail.com>
Date: Tue, 29 Mar 2005 19:55:30 +0200
From: Mateusz Berezecki <mateuszb@gmail.com>
Reply-To: Mateusz Berezecki <mateuszb@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: PCI bus mastering question
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello dear list readers,


I've been googling on the topic for a couple of minutes and I got some question.
If PCI bus mastering means the device gets the control over the bus and does all
device voodoo is it possible to achieve the same effects without using
mastering?
To be more specific: if the device wrote some - let's say register for
example - to a
memory location, would the result be identical if a kernel read the
same register from a device and stored it somewhere in memory? Or does
mastering trigger some special
stuff in a device so it acts different?


kind regards
/mb
