Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932155AbWEGNVD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbWEGNVD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 09:21:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932158AbWEGNVD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 09:21:03 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:44493
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S932155AbWEGNVB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 09:21:01 -0400
From: Michael Buesch <mb@bu3sch.de>
To: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: [patch 2/6] New Generic HW RNG
Date: Sun, 7 May 2006 15:27:33 +0200
User-Agent: KMail/1.9.1
References: <20060507113513.418451000@pc1> <20060507170320.3ce0d3e0.vsu@altlinux.ru> <200605071516.09167.mb@bu3sch.de>
In-Reply-To: <200605071516.09167.mb@bu3sch.de>
Cc: akpm@osdl.org, Deepak Saxena <dsaxena@plexity.net>,
       bcm43xx-dev@lists.berlios.de, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605071527.33376.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 07 May 2006 15:16, you wrote:
> On Sunday 07 May 2006 15:03, you wrote:
> > This does not handle the case of partial read correctly - the code
> > should be
> > 
> > 			return ret ? : -ERESTARTSYS;

Or, hm. Shouldn't we
return ret ? : err;

err is -EINTR

-- 
Greetings Michael.
