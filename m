Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932254AbVILV1b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbVILV1b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 17:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932259AbVILV1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 17:27:31 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:22137 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932254AbVILV1a convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 17:27:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=TOvMhxrtEV5GjTPO+/c9++T88cgqoXSqPs4FtgkZxu5nEG3aNxiTXvEviA/vMN+AALSVddA2yjuGmQargpl54zP0PgVHfWfXn4TslNRV9ogUWtaBWziJkfUaai8iyX8lHM/w6Ea6luxL6DqImOf8fc2fTEVYM8w1qxEzo/D1ATQ=
Message-ID: <6bffcb0e050912142757f9aaa1@mail.gmail.com>
Date: Mon, 12 Sep 2005 23:27:28 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Reply-To: michal.k.k.piotrowski@gmail.com
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.6.13-mm3 dontdiff - asm-offsets.*
Cc: Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
here is my simple dontdiff patch.

It maybe someone mistake, but there are two asm-offsets files in
include/asm-i386/.

ng02:/usr/src/linux-mm/include/asm-i386# ls | grep "asm"
asm_offsets.h
asm-offsets.h

Regards,
Michal Piotrowski

Signed-off-by: Michal K. K. Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-mm-clean/Documentation/dontdiff
linux-mm-clean/Documentation/dontdiff linux-mm/Documentation/dontdiff
--- linux-mm-clean/Documentation/dontdiff	2005-09-12 23:01:28.000000000 +0200
+++ linux-mm/Documentation/dontdiff	2005-09-12 23:18:42.000000000 +0200
@@ -55,6 +55,7 @@ aic7*seq.h*
 aicasm
 aicdb.h*
 asm
+asm-offsets.*
 asm_offsets.*
 autoconf.h*
 bbootsect
