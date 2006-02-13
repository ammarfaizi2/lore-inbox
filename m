Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751213AbWBMHsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbWBMHsX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 02:48:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbWBMHsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 02:48:23 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:49087 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751202AbWBMHsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 02:48:22 -0500
Subject: Re: max symlink = 5? ?bug? ?feature deficit?
From: Arjan van de Ven <arjan@infradead.org>
To: Willy Tarreau <willy@w.ods.org>
Cc: Linda Walsh <lkml@tlinx.org>, Al Viro <viro@ftp.linux.org.uk>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <20060213073746.GG11380@w.ods.org>
References: <43ED5A7B.7040908@tlinx.org>
	 <20060212180601.GU27946@ftp.linux.org.uk> <43EFA63B.30907@tlinx.org>
	 <20060212212504.GX27946@ftp.linux.org.uk> <43EFBCA9.1090501@tlinx.org>
	 <20060213000803.GY27946@ftp.linux.org.uk> <43EFD8BF.1040205@tlinx.org>
	 <20060213073746.GG11380@w.ods.org>
Content-Type: text/plain
Date: Mon, 13 Feb 2006 08:48:15 +0100
Message-Id: <1139816896.2997.19.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I don't know exactly why recursion is used to follow symlinks,
> which at first thought seems like it could be iterated, but
> I've not checked the code, there certainly are specific reasons
> for this.

the problem is not following symlinks. the problem is symlinks to
symlink to symlink to ...



