Return-Path: <linux-kernel-owner+w=401wt.eu-S932724AbWLNN7B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932724AbWLNN7B (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 08:59:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932731AbWLNN7B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 08:59:01 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:48742 "EHLO
	mailhub.fokus.fraunhofer.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932724AbWLNN7A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 08:59:00 -0500
X-Greylist: delayed 706 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Dec 2006 08:59:00 EST
Date: Thu, 14 Dec 2006 14:46:05 +0100
From: Joerg.Schilling@fokus.fraunhofer.de (Joerg Schilling)
To: linux-kernel@vger.kernel.org, teunis@alphatrade.com
Subject: Re: 2.6.19 kernel series, SATA, wodim (cd recording), synaptics
 update,
Message-ID: <4581559d.iqe9L1/wj2D5j93L%Joerg.Schilling@fokus.fraunhofer.de>
User-Agent: nail 11.22 3/20/05
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>CD recording : recorder no longer detected by "wodim" software set in
>2.6.19.   I suspect it's a bug in the software...  but don't know where
>to look for changes.   2.6.19-rc5 worked.
>hardware: IDE MATSHITADVD-RAM UJ-820S
>(2.6.19-git6 also fails with external LiteON USB DVD burner)

I recommend to check the latest cdrtools packet from:

ftp://ftp.berlios.de/pub/cdrecord/alpha/

At the same place, there is a patch for recent Linux systems
that allows cdrecord to sense the MAX DMA size for USB.

Do not use cdrecord derivates but the original as derivates may have bugs
that are not present in the original.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
