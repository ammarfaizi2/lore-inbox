Return-Path: <linux-kernel-owner+w=401wt.eu-S932330AbXAONgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbXAONgn (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 08:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932335AbXAONgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 08:36:43 -0500
Received: from an-out-0708.google.com ([209.85.132.243]:43890 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932330AbXAONgm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 08:36:42 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Jl0b/qgbKEUty+vNXFKkpoyLiHV90aVCerWdnKJsd77cEstRrXbWBWOlC73ikbGI0GG+dgfkmRFmBPL+P2/51k37dkZgFSZa8ZN2Xmhxnns2aqxgv/IZlfbr2SiT1HgwkgQWWgL7AwHR40VnDKRSvvTyrnIbFBHV1pXd293gDHE=
Message-ID: <5d96567b0701150536j4c3c50abndec5155ddb53d4a1@mail.gmail.com>
Date: Mon, 15 Jan 2007 15:36:41 +0200
From: "Raz Ben-Jehuda(caro)" <raziebe@gmail.com>
To: "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: [DISCUSS] memory allocation method
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a process who allocates as much as possible of RAM
in 4 G ram 32bit machine.  This buffer is never released.

Questions:

1. Is it better allocates with many 1MB buffers or allocate it in with
one a big valloc ?

2. I will be needing to make this memory allocation in many other
machines , some have 2 GRAM and some 3 GRAM. what is the preferrable
method  ?

3. In 64bit machines , is it possible to allocate huge buffers , such
as 30 GB of ram ?

Thank you
-- 
Raz
