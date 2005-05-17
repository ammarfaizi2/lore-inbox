Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261202AbVEQGNN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbVEQGNN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 02:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261213AbVEQGNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 02:13:08 -0400
Received: from ercist.iscas.ac.cn ([159.226.5.94]:19214 "EHLO
	ercist.iscas.ac.cn") by vger.kernel.org with ESMTP id S261184AbVEQGND
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 02:13:03 -0400
Subject: RE: [RFD] What error should FS return when I/O failure occurs?
From: fs <fs@ercist.iscas.ac.cn>
To: "Hua Zhong (hzhong)" <hzhong@cisco.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       Kenichi Okuyama <okuyama@intellilink.co.jp>
In-Reply-To: <75D9B5F4E50C8B4BB27622BD06C2B82B2264F7@xmb-sjc-235.amer.cisco.com>
References: <75D9B5F4E50C8B4BB27622BD06C2B82B2264F7@xmb-sjc-235.amer.cisco.com>
Content-Type: text/plain
Organization: iscas
Message-Id: <1116350444.2428.46.camel@CoolQ>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 17 May 2005 13:20:45 -0400
Content-Transfer-Encoding: 7bit
X-ArGoMail-Authenticated: fs@ercist.iscas.ac.cn
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-17 at 02:00, Hua Zhong (hzhong) wrote:
> The thing is the EIO almost always happens at background so there is no
> way to return it to the user space. If you want to see EIO, do fsync
> explicitly.
even with fsync, the result is still EROFS,
you can visit
http://developer.osdl.jp/projects/doubt/fs-consistency-and-coherency/
to see the result. 



