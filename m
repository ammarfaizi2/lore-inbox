Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964800AbWFHIu7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbWFHIu7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 04:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964801AbWFHIu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 04:50:59 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:26781 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S964800AbWFHIu7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 04:50:59 -0400
Message-ID: <349756654.19100@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Thu, 8 Jun 2006 16:50:55 +0800
From: Fengguang Wu <wfg@mail.ustc.edu.cn>
To: Voluspa <lista1@comhem.se>
Cc: akpm@osdl.org, arjan@infradead.org, Valdis.Kletnieks@vt.edu,
       diegocg@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] readahead: initial method - expected read size - fix fastcall
Message-ID: <20060608085055.GA5917@mail.ustc.edu.cn>
Mail-Followup-To: Fengguang Wu <wfg@mail.ustc.edu.cn>,
	Voluspa <lista1@comhem.se>, akpm@osdl.org, arjan@infradead.org,
	Valdis.Kletnieks@vt.edu, diegocg@gmail.com,
	linux-kernel@vger.kernel.org
References: <349406446.10828@ustc.edu.cn> <20060604020738.31f43cb0.akpm@osdl.org> <1149413103.3109.90.camel@laptopd505.fenrus.org> <20060605031720.0017ae5e.lista1@comhem.se> <349562623.17723@ustc.edu.cn> <20060608094356.5c1272cc.lista1@comhem.se> <349754431.09938@ustc.edu.cn> <20060608102802.6e07b148.lista1@comhem.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060608102802.6e07b148.lista1@comhem.se>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2006 at 10:28:02AM +0200, Voluspa wrote:
> On Thu, 8 Jun 2006 16:13:52 +0800 Fengguang Wu wrote:
> > It's interesting that copying of sparse file is more efficient with small
> > readahead size :) I get the same conclusion, though with smaller differences:
> 
> How on earth can you copy the file without overwriting the target /dev/null?

Yes, it worked as expected. All the time.

I'm running zsh, though bash is also tested ok.

% cp --version
cp (GNU coreutils) 5.96
Copyright (C) 2006 Free Software Foundation, Inc.

Wu
