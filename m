Return-Path: <linux-kernel-owner+w=401wt.eu-S932270AbXADDS2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbXADDS2 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 22:18:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbXADDS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 22:18:28 -0500
Received: from nz-out-0506.google.com ([64.233.162.226]:13696 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932269AbXADDS1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 22:18:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=FwWGUQh7VykvAOh+UcBF4HOnkGd2EHuhp8vhXjh8dGdlmuSSRnBwZ4ez10/NFODjiKWiaq6cX4WaMuPO8I757/SBF0IOb7pj8ZEU+D+u9VTr1Lj/3hN5bB1TW9iHu2nX1dAlT/viQgOgX37DGrIamA1T387RFF/0UdcAVg3QnYo=
Message-ID: <459C71FC.3010503@gmail.com>
Date: Thu, 04 Jan 2007 12:18:20 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: Andrew Lyon <andrew.lyon@gmail.com>
CC: bbee <bumble.bee@xs4all.nl>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive
 0x0) r0xj0
References: <f4527be0612271812p7282de31j98462aebde16e5a1@mail.gmail.com>	 <45933A53.1090702@gmail.com> <loom.20070103T020347-255@post.gmane.org>	 <459B140C.1060401@gmail.com>	 <Pine.LNX.4.64.0701030334460.12309@dolores.legate.org>	 <459B2DEA.8080202@gmail.com>	 <Pine.LNX.4.64.0701031733001.1969@dolores.legate.org> <f4527be0701031701q4eaafe63sfd5dcbbfddc89f51@mail.gmail.com>
In-Reply-To: <f4527be0701031701q4eaafe63sfd5dcbbfddc89f51@mail.gmail.com>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Lyon wrote:
> Is there anything more I can do to assist? I plan to upgrade to
> 2.6.19/latest at the weekend, let me know if there is anything more i
> can do.

WD740ADFD-00 is blacklisted for NCQ in .20-rcX kernels, so you won't see
the problem anymore there.  If you're gonna use 2.6.19, you probably
wanna patch it.

-- 
tejun
