Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262364AbVCBRJj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262364AbVCBRJj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 12:09:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262353AbVCBRJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 12:09:12 -0500
Received: from moutng.kundenserver.de ([212.227.126.176]:27868 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262364AbVCBRH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 12:07:26 -0500
From: Holger Klawitter <listen@klawitter.de>
Date: Wed, 2 Mar 2005 18:07:11 +0100
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Disposition: inline
To: linux-kernel@vger.kernel.org
Subject: 2.6.11: usbnet broken
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200503021807.11717.listen@klawitter.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:c3f09bf0911098d231c83d2978ee4594
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

in 2.6.11 the usbnet module is not being loaded for my Zaurus SL-C860 (Vendor 
ID = 044d, Product ID = 9031), which used to work in 2.6.10. (as stated in 
previous post, rc4 and rc5 were also broken).

Moreover, there seems to be a wrong Product ID in usbnet (already in 2.6.9): 
is=9050 should be=9031. Hence my Zarus is being recognized as C-750/760 
(which is fine as 760 and 860 only differ in memsize).

Regards
  Holger Klawitter
