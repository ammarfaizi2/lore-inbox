Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261467AbVEPJDk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbVEPJDk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 05:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbVEPJDk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 05:03:40 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:59063 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261467AbVEPJDf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 05:03:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:subject:message-id:mime-version:content-type:content-disposition:content-transfer-encoding:user-agent:from;
        b=PlXNVxv82QP172M84HHJfPX0ninNhfNBtuwqJQggYGGgCysz88x6/EfpKBBl4nam3vRxu5Ishq62DWpyCq4rwYGjdn9FuIYGubKRiykPNRgDgC4XH8oV5Axv+x/7czhBQli2ras3Nxx2z7smjSPDeMfBWvuWrtAXxRn0Ze95yrY=
Date: Mon, 16 May 2005 10:58:32 +0200
To: linux-kernel@vger.kernel.org
Subject: What breaks aic7xxx in post 2.6.12-rc2 ?
Message-ID: <20050516085832.GA9558@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.6i
From: =?iso-8859-1?Q?Gr=E9goire?= Favre <gregoire.favre@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

as I reported in
http://marc.theaimsgroup.com/?l=linux-kernel&m=111554477416794&w=2

I have lots of problem with aic7xxx (and till 2.6.12-rc2 everything
works perfectly). I have tried to compil 2.6.12-rc4-mm1 without probe
all Lun and it don't change anything at all to this problem.

I have two different controllers :

0000:00:05.0 SCSI storage controller: Adaptec AIC-7892A U160/m (rev 02)
0000:00:0a.0 SCSI storage controller: Adaptec AHA-2940U/UW/D / AIC-7881U

And I also use libsata.

Anyone got an idea on what's going wrong ?

Please CC to me : I am not on this mailinglist.
-- 
	Grégoire Favre
