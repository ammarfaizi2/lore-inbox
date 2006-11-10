Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946688AbWKJOo1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946688AbWKJOo1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 09:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424402AbWKJOo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 09:44:27 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:36229 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1424401AbWKJOo0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 09:44:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iL8ldnICA9MgTj3UDJ9gTnDtDZTghwBzWLXVfKkY5gwl60QEITunfHoKB79T65ZmwT9qFtkYyEeExsjhPbXXu+gSOxJNlFrd46jhIZ6tY06Z8xh80TJUDUzur1NIqGoG/XMsIlqQ/9jqt581ct/Kq128siHf2Gy0748nKOqH4eA=
Message-ID: <bde600590611100644r4e42484rf0f5d7a4e75327a5@mail.gmail.com>
Date: Fri, 10 Nov 2006 17:44:25 +0300
From: "Igor A. Valcov" <viaprog@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: XFS filesystem performance drop in kernels 2.6.16+
In-Reply-To: <bde600590611100516u7b8ca1bfs74d3cc8b78eb3520@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <bde600590611090930g3ab97aq3c76d7bca4ec267f@mail.gmail.com>
	 <4553F3C6.2030807@sandeen.net>
	 <Pine.LNX.4.61.0611101259490.6068@yvahk01.tjqt.qr>
	 <bde600590611100516u7b8ca1bfs74d3cc8b78eb3520@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is a same test on ext4dev

============ 2.6.19-rc5-git2 ============

mount -t ext4dev -o extents /dev/sdc1 /mnt/disc

real    41m55.445s
user    0m24.242s
sys     14m20.302s

-- 
Igor A. Valcov
