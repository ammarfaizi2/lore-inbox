Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262543AbTGHNfG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 09:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267300AbTGHNfG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 09:35:06 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:50859
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262543AbTGHNfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 09:35:04 -0400
Subject: Re: [PATCH] Add SELinux module to 2.5.74-bk1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: James Morris <jmorris@intercode.com.au>, jgarzik@pobox.com,
       sds@epoch.ncsc.mil, torvalds@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk, hch@infradead.org,
       greg@kroah.com, chris@wirex.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030708030931.6864972b.akpm@osdl.org>
References: <20030703175153.GC27556@gtf.org>
	 <Mutt.LNX.4.44.0307081942550.7740-100000@excalibur.intercode.com.au>
	 <20030708030931.6864972b.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1057671907.4352.13.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 08 Jul 2003 14:45:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-07-08 at 11:09, Andrew Morton wrote:
> Comparing the complexity (size) of this code with the q-n-d hash tables
> which are currently used one does wonder how useful it all will be.  The
> additional indirections are not needed with q-n-d hashes.

Are these new hashes immune to deliberate attack (witness the network
routing hash paper)

