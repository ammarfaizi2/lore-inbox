Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262014AbUK3IYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262014AbUK3IYk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 03:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262017AbUK3IYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 03:24:39 -0500
Received: from cpc5-hem13-6-0-cust134.lutn.cable.ntl.com ([82.6.21.134]:2814
	"EHLO arkady.demon.co.uk") by vger.kernel.org with ESMTP
	id S262014AbUK3IW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 03:22:28 -0500
Message-ID: <41AC2DBE.1080501@ntlworld.com>
Date: Tue, 30 Nov 2004 08:22:22 +0000
From: Bernard Hatt <bernard.hatt@ntlworld.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Yet another filesystem - sffs
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I had an idea for a filesystem as an alternative to using a raw disk
partition for storing a single (large) data file (eg. a DVD image or a
database data file), adding the convenience of a file length, permissions
and a uid/gid.

As I now have some functional code (a 'compile outside the kernel'
module, only tested against i386/2.6.9) I thought I'd share the sffs
(single file file-system) code for comments/testing.

Performance for a single file is between 0 and 40% faster than ext2,
(though sffs is not a general purpose filesystem).

Some more details/benchmarks:
         http://www.arkady.demon.co.uk/sffs
the code can be downloaded from:
         http://www.arkady.demon.co.uk/sffs/sffs-latest.tar.gz (13.5k)

Regards,

Bernard




