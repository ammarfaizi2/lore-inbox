Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268892AbUHUIM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268892AbUHUIM4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 04:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268893AbUHUIM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 04:12:56 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:30986 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S268892AbUHUIMz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 04:12:55 -0400
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: "Josan Kadett" <corporate@superonline.com>,
       "'Aidas Kasparas'" <a.kasparas@gmc.lt>
Subject: RE: Entirely ignoring TCP and UDP checksum in kernel level
Date: Sat, 21 Aug 2004 11:11:23 +0300
X-Mailer: KMail [version 1.4]
Cc: <linux-kernel@vger.kernel.org>
References: <S268889AbUHUIAZ/20040821080025Z+1903@vger.kernel.org>
In-Reply-To: <S268889AbUHUIAZ/20040821080025Z+1903@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200408211111.24019.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 21 August 2004 12:00, Josan Kadett wrote:
> The problem is that the interface 192.168.1.1 does not allow any
> tranmission to occur. An implementation error I think... We send packets to
> 192.168.1.1, we get no reply, but when we send packets to 192.168.77.1 we
> get the replies (that is where the abnormality begins). However; the
> replies are now sourced from 192.168.1.1 instead. That is, the blasted code
> in the device calculates the checksum using the wrong IP address which it
> thinks it is assigned to...

Maybe dust off some old Pentium 133 and replace that piece of electronic
crap with decent Linux machine?
-- 
vda
