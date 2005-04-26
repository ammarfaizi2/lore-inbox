Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261516AbVDZNrD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261516AbVDZNrD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 09:47:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261512AbVDZNqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 09:46:54 -0400
Received: from herkules.vianova.fi ([194.100.28.129]:27086 "HELO
	mail.vianova.fi") by vger.kernel.org with SMTP id S261520AbVDZNqj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 09:46:39 -0400
Date: Tue, 26 Apr 2005 16:46:29 +0300
From: Ville Herva <v@iki.fi>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: filesystem transactions API
Message-ID: <20050426134629.GU16169@viasys.com>
References: <20050424211942.GN13052@parcelfarce.linux.theplanet.co.uk> <OF32F95BBA.F38B2D1F-ON88256FEE.006FE841-88256FEE.00742E46@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF32F95BBA.F38B2D1F-ON88256FEE.006FE841-88256FEE.00742E46@us.ibm.com>
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux herkules.viasys.com 2.4.27
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apparently, Windows Longhorn will include something called "transactional
NTFS". It's explained pretty well in

   http://blogs.msdn.com/because_we_can/

Basically, a process can create a fs transaction, and all fs changes made
between start of the transaction and commit are atomical - meaning nothing
is visible until commit, and if commit fails, everything is rolled back.

Sound useful... Although there are no service pack installs that could fail
in Linux, the same thing could be useful in rpm, yum, almost anything. 

What do you think?



-- v -- 

v@iki.fi

