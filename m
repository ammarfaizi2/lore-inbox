Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262139AbVATMsb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262139AbVATMsb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 07:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262140AbVATMsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 07:48:31 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:36202 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262139AbVATMs1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 07:48:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=U9Ch6nmWcvs5acvXYoMnkGACDWOrEG2nPTgtyxVAqKX64d8SG3M5QEYBubS/wUb6JD5qdl3Mj+vIx57dOIlKUDfj4IWrl1M33orvyfoME5FvoCZiK27Q9ymAOeS7uQpC1YlOhSVwXcOO7PS0xrWPY5Eed3ICz04zz6me9ebH490=
Message-ID: <41ae44840501200448197d18c0@mail.gmail.com>
Date: Thu, 20 Jan 2005 18:18:26 +0530
From: Kausty <kkumbhalkar@gmail.com>
Reply-To: Kausty <kkumbhalkar@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: crypto/api.c: crypto_alg_available(): flags param not used.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi
A small observation. In crypto/api.c in linux-2.6.8.1

The function:
int crypto_alg_available(const char *name, u32 flags)

has a flags param which does not seem to be used.

though it does not matter much but has this been fixed in later releases?
xfrm functions in ipsec do call this function but always with flags as 0.

Thanks and regards
kausty

(sorry... not subscribed to this list, pls CC if any valuable info)
