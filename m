Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261160AbUKBJwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbUKBJwy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 04:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261155AbUKBJwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 04:52:54 -0500
Received: from 4s.enrico.unife.it ([192.167.219.82]:62668 "EHLO
	quatresse.ferrara.linux.it") by vger.kernel.org with ESMTP
	id S261166AbUKBJjM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 04:39:12 -0500
From: Fabio Coatti <cova@ferrara.linux.it>
Organization: FerraraLUG
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: Test patch for ub and double registration
Date: Tue, 2 Nov 2004 10:39:09 +0100
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, cs@tequila.co.jp
References: <20041101164432.3fa72b81@lembas.zaitcev.lan>
In-Reply-To: <20041101164432.3fa72b81@lembas.zaitcev.lan>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200411021039.10128.cova@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alle 01:44, martedì 2 novembre 2004, Pete Zaitcev ha scritto:
> Hello,
>
> here's a patch to fix the double kobject registration problem with the ub.
> One little problem here is that I do not have a device which fails this
> way, so I would like owners of such devices to give it a try.
>
> The latest victim of this is Fabio Coatti. It should be noted that this
> fix only (supposed to) prevents oopses on deregistration. If the device
> doesn't work generally (for example, requires START STOP UNIT), it won't
> help that.

Ill'try this patch in a few hours, report will follow ASAP; 

thanks.

-- 
Fabio "Cova" Coatti    http://members.ferrara.linux.it/cova     
Ferrara Linux Users Group           http://ferrara.linux.it
GnuPG fp:9765 A5B6 6843 17BC A646  BE8C FA56 373A 5374 C703
Old SysOps never die... they simply forget their password.
