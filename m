Return-Path: <linux-kernel-owner+w=401wt.eu-S1752663AbWLVUvk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752663AbWLVUvk (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 15:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752672AbWLVUvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 15:51:40 -0500
Received: from moutng.kundenserver.de ([212.227.126.179]:62376 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752663AbWLVUvk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 15:51:40 -0500
X-Greylist: delayed 324 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Dec 2006 15:51:39 EST
From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: two architectures,same source tree
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@lazybastard.org>,
       Yakov Lerner <iler.ml@gmail.com>, Kernel <linux-kernel@vger.kernel.org>
Reply-To: 7eggert@gmx.de
Date: Fri, 22 Dec 2006 21:45:26 +0100
References: <7uewg-7Un-7@gated-at.bofh.it> <7ueZm-17M-25@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1GxrGg-0001SL-3h@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@gmx.de
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:9b3b2cc444a07783f194c895a09f1de9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel <joern@lazybastard.org> wrote:
> On Wed, 20 December 2006 20:32:20 +0200, Yakov Lerner wrote:

>> Is it easily possible to build two architectures in
>> the same source tree (so that intermediate fles
>> and resut files do not interfere ) ?
> 
> I'd try something like this:
> make O=../foo ARCH=foo
> make O=../bar ARCH=bar
> 
> But as I'm lazy I'll leave the debugging to you. :)

IIRC You'll have to specify ARCH= on each make call, but O= is saved in
../foo/Makefile.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.

http://david.woodhou.se/why-not-spf.html
