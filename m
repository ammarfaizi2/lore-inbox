Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752845AbWKBNTF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752845AbWKBNTF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 08:19:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752847AbWKBNTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 08:19:04 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:48830 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1752845AbWKBNTC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 08:19:02 -0500
Subject: RE: Can Linux live without DMA zone?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Conke Hu <conke.hu@amd.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Jun Sun <jsun@junsun.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <FFECF24D2A7F6D418B9511AF6F358602F2D5DF@shacnexch2.atitech.com>
References: <FFECF24D2A7F6D418B9511AF6F358602F2D5DF@shacnexch2.atitech.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 02 Nov 2006 13:09:26 +0000
Message-Id: <1162472966.11965.180.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-11-02 am 18:33 +0800, ysgrifennodd Conke Hu:
> Most PCs do not have ISA or floppy, so maybe we could add an option to enable DMA zone or not.

Lots of hardware still needs memory below the 2GB boundary, or for
floppy etc (which is common) in the low 16MB. People are still shipping
wireless hardware with these kind of limits even today.

