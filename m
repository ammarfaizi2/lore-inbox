Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262633AbVAPWbf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262633AbVAPWbf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 17:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262642AbVAPWbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 17:31:34 -0500
Received: from [195.110.122.101] ([195.110.122.101]:34275 "EHLO
	cadalboia.ferrara.linux.it") by vger.kernel.org with ESMTP
	id S262647AbVAPW2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 17:28:06 -0500
From: Simone Piunno <pioppo@ferrara.linux.it>
To: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10-mm2: it87 sensor driver stops CPU fan
Date: Sun, 16 Jan 2005 23:32:10 +0100
User-Agent: KMail/1.7.2
Cc: "Greg KH" <greg@kroah.com>, "Jonas Munsin" <jmunsin@iki.fi>, djg@pdp8.net
References: <g7Idbr9m.1105713630.9207120.khali@localhost> <200501151654.46412.pioppo@ferrara.linux.it> <20050115175545.743a39f9.khali@linux-fr.org>
In-Reply-To: <20050115175545.743a39f9.khali@linux-fr.org>
X-Key-URL: http://members.ferrara.linux.it/pioppo/mykey.asc
X-Key-FP: 9C15F0D3E3093593AC952C92A0CD52B4860314FC
X-Key-ID: 860314FC/C09E842C
X-Message: GnuPG/PGP5 are welcome
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501162332.14324.pioppo@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

While we're at it, the fan speed sensor reports an absurd speed when the fan 
is driven with very low but non-zero pwm values.  For example, driving it 
with pwm=2 I get speeds over 50K rpms, while of course the fan is stopped 
(almost?).  This could be just an hardware sensitivity problem in the sensor 
chip, or a false measure triggered by fan vibration, but maybe you know 
better.

/Simone

-- 
http://thisurlenablesemailtogetthroughoverzealousspamfilters.org
