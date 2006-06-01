Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751790AbWFAFvU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751790AbWFAFvU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 01:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751796AbWFAFvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 01:51:20 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:63443 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1751790AbWFAFvT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 01:51:19 -0400
Message-ID: <349141076.14929@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Thu, 1 Jun 2006 13:51:43 +0800
From: Fengguang Wu <wfg@mail.ustc.edu.cn>
To: Voluspa <lista1@comhem.se>
Cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: Adaptive Readahead V14 - statistics question...
Message-ID: <20060601055143.GA5216@mail.ustc.edu.cn>
Mail-Followup-To: Fengguang Wu <wfg@mail.ustc.edu.cn>,
	Voluspa <lista1@comhem.se>, Valdis.Kletnieks@vt.edu,
	linux-kernel@vger.kernel.org
References: <20060530053631.57899084.lista1@comhem.se> <200605301649.k4UGnooZ004266@turing-police.cc.vt.edu> <20060531235021.41a58425.lista1@comhem.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060531235021.41a58425.lista1@comhem.se>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2006 at 11:50:21PM +0200, Voluspa wrote:
> _Massive READ_
> 
> [/usr had some 490000 files]
> 
> "cd /usr ; time find . -type f -exec md5sum {} \;"
> 
> 2.6.17-rc5 ------- 2.6.17-rc5-ar
> 
> real 21m21.009s -- 21m37.663s
> user 3m20.784s  -- 3m20.701s
> sys  6m34.261s  -- 6m41.735s
> 
> I had planned to run this at least three times, but didn't realize I had
> 12 compiled kernel trees and 3 uncompiled there... So, a one-shot had to
> do. But it's still significant.

Sorry, it is a known regression. I'd like to fix it in the next
release.

Thanks,
Wu
