Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129030AbQKEMjz>; Sun, 5 Nov 2000 07:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129164AbQKEMjp>; Sun, 5 Nov 2000 07:39:45 -0500
Received: from mailgate2.zdv.Uni-Mainz.DE ([134.93.8.57]:15351 "EHLO
	mailgate2.zdv.Uni-Mainz.DE") by vger.kernel.org with ESMTP
	id <S129030AbQKEMjf>; Sun, 5 Nov 2000 07:39:35 -0500
Date: Sun, 5 Nov 2000 13:39:28 +0100
From: Dominik Kubla <dominik.kubla@uni-mainz.de>
To: "H. Peter Anvin" <hpa@transmeta.com>
Cc: Dominik Kubla <dominik.kubla@uni-mainz.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: ext3 vs. JFS file locations...
Message-ID: <20001105133928.A25131@uni-mainz.de>
Mail-Followup-To: "H. Peter Anvin" <hpa@transmeta.com>,
	Dominik Kubla <dominik.kubla@uni-mainz.de>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3A02D150.E7E87398@usa.net> <200011031725.eA3HPwP12932@webber.adilger.net> <8tv3tm$iqg$1@cesium.transmeta.com> <20001105024621.A29327@uni-mainz.de> <3A04CA8F.D19535B1@transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <3A04CA8F.D19535B1@transmeta.com>; from hpa@transmeta.com on Sat, Nov 04, 2000 at 06:48:47PM -0800
X-No-Archive: yes
Restrict: no-external-archive
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 04, 2000 at 06:48:47PM -0800, H. Peter Anvin wrote:

> Because -fs is usually used by filesystems itself.  Since the journaling
> layer doesn't really have a publically visible name, it's easy to change.

Oh i understood that fine. But VFS = "virtual filesystem switch" is also
not a filesystem per se. And why give the generic term to an IBM "product"?
So i say leave jfs for generic code and call the IBM jfs "ibmjfs".

Just my 2 cents,
  Dominik Kubla
-- 
http://petition.eurolinux.org/index_html - No Software Patents In Europe!
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
