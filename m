Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbTKCNhn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 08:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbTKCNhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 08:37:43 -0500
Received: from gateway.caplin.com ([195.110.77.253]:53517 "EHLO
	gateway.caplin.com") by vger.kernel.org with ESMTP id S261757AbTKCNhn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 08:37:43 -0500
From: Luke Driscoll <newsregister@driscollnewsletter.com>
To: linux-kernel@vger.kernel.org
Subject: NFS on 2.6.0-test9
Date: Mon, 3 Nov 2003 13:42:35 +0000
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200311031342.35857.newsregister@driscollnewsletter.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On a kernel 2.6.0-test9 as an NFS client I am having trouble transferring
data to and from NFS servers. It it extraordinarily slow.  I receive the
following information in dmesg:

nfs warning: mount version older than kernel
nfs: server safe not responding, still trying
nfs: server safe not responding, still trying
nfs: server safe not responding, still trying
nfs: server safe not responding, still trying

I have also upgraded util-linux to 2.12pre

I am using various NFS servers, Solaris 2.8, Solaris 2.6, linux 2.4 and of
all things a windows server with NFS. It seems to suffer when connecting to
any one of them. 

I have built from the default 2.6.0-test9 source.

