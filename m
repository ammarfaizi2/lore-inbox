Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261212AbVAHQty@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbVAHQty (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 11:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261213AbVAHQty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 11:49:54 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:9924 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261212AbVAHQtw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 11:49:52 -0500
Subject: Re: [PATCH] fs: Restore files_lock and set_fs_root exports
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>, mingo@elte.hu,
       viro@parcelfarce.linux.theplanet.co.uk, paulmck@us.ibm.com,
       arjan@infradead.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       jtk@us.ibm.com, wtaber@us.ibm.com, pbadari@us.ibm.com, markv@us.ibm.com,
       greghk@us.ibm.com, torvalds@osdl.org
In-Reply-To: <20050107145801.64d55cd3.akpm@osdl.org>
References: <20050106203258.GN26051@parcelfarce.linux.theplanet.co.uk>
	 <20050106210408.GM1292@us.ibm.com>
	 <20050106212417.GQ26051@parcelfarce.linux.theplanet.co.uk>
	 <20050106152621.395f935e.akpm@osdl.org>
	 <20050106234123.GA27869@infradead.org>
	 <20050106162928.650e9d71.akpm@osdl.org>
	 <20050107002624.GA29006@infradead.org> <20050107090014.GA24946@elte.hu>
	 <20050107091542.GA5295@infradead.org>
	 <20050107140034.46aec534.akpm@osdl.org>
	 <20050107221905.GA17567@infradead.org>
	 <20050107145801.64d55cd3.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105196324.10519.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 08 Jan 2005 15:45:04 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-01-07 at 22:58, Andrew Morton wrote:
> You still have not demonstrated any benefit to any party from not delaying
> the removal of these two exports.

Trivial one: it saves memory 8)

