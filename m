Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262478AbVAPLEg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262478AbVAPLEg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 06:04:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262479AbVAPLEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 06:04:36 -0500
Received: from rproxy.gmail.com ([64.233.170.207]:11215 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262478AbVAPLEd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 06:04:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Z+hDUQ+xy7qtjLs/IM5wCbJ9FACNEwxrNabXZWCXN6EO2tVnv9yLw01Z0zkqC5k7by4DwWMCF4M1IwLpsdbJJbslKj2S9cz260y++gGfF1cGihkiGqsV3l/GHTlYvxU8Q/wWi4+yQLaP4ly7MaZljsQ2lo9qOq1KNFpZzfshg2M=
Message-ID: <9e4733910501160304642f7882@mail.gmail.com>
Date: Sun, 16 Jan 2005 06:04:32 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Helge Hafting <helgehaf@aitel.hist.no>
Subject: Re: 2.6.10 dies when X tries to initialize PCI radeon 9200 SE
Cc: Dave Airlie <airlied@gmail.com>, covici@ccs.covici.com,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050116105011.GA5882@hh.idb.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41E64DAB.1010808@hist.no>
	 <16870.21720.866418.326325@ccs.covici.com>
	 <21d7e997050113130659da39c9@mail.gmail.com>
	 <20050115185712.GA17372@hh.idb.hist.no>
	 <21d7e997050116020859687c4a@mail.gmail.com>
	 <20050116105011.GA5882@hh.idb.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

you need to check the output from "modprobe drm debug=1" "modprobe
radeon" and see if drm is misidentifying the board as AGP. We don't
want to fix something if it isn't broken.

-- 
Jon Smirl
jonsmirl@gmail.com
