Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbVIQAvu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbVIQAvu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 20:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbVIQAvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 20:51:50 -0400
Received: from main.gmane.org ([80.91.229.2]:35279 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750794AbVIQAvt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 20:51:49 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: sean <seandarcy2@gmail.com>
Subject: git3 build dies at net/built-in.o: undefined __nfa_fill
Date: Fri, 16 Sep 2005 20:50:54 -0400
Message-ID: <dgfp9f$7i8$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ool-4577675c.dyn.optonline.net
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.11) Gecko/20050914 Fedora/1.7.11-5
X-Accept-Language: en-us, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On amd64, gcc-4.0.1:

.....
   GEN     .version
   CHK     include/linux/compile.h
   UPD     include/linux/compile.h
   CC      init/version.o
   LD      init/built-in.o
   LD      .tmp_vmlinux1
net/built-in.o: In function `ip_ct_port_tuple_to_nfattr':
: undefined reference to `__nfa_fill'
net/built-in.o: In function `ip_ct_port_tuple_to_nfattr':
: undefined reference to `__nfa_fill'
net/built-in.o: In function `tcp_to_nfattr':
: undefined reference to `__nfa_fill'
net/built-in.o: In function `icmp_tuple_to_nfattr':
: undefined reference to `__nfa_fill'
net/built-in.o: In function `icmp_tuple_to_nfattr':
: undefined reference to `__nfa_fill'
net/built-in.o:: more undefined references to `__nfa_fill' 
follow
make: *** [.tmp_vmlinux1] Error 1

