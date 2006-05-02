Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964925AbWEBQkw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964925AbWEBQkw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 12:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964924AbWEBQkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 12:40:52 -0400
Received: from [212.33.180.75] ([212.33.180.75]:63750 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S964922AbWEBQkw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 12:40:52 -0400
From: Al Boldi <a1426z@gawab.com>
To: NeilBrown <neilb@suse.de>
Subject: Re: [PATCH 009 of 11] md: Support stripe/offset mode in raid10
Date: Tue, 2 May 2006 19:38:45 +0300
User-Agent: KMail/1.5
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
References: <20060501152229.18367.patches@notabene> <1060501053054.23009@suse.de>
In-Reply-To: <1060501053054.23009@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Message-Id: <200605021938.45254.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NeilBrown wrote:
> The "industry standard" DDF format allows for a stripe/offset layout
> where data is duplicated on different stripes. e.g.
>
>   A  B  C  D	
>   D  A  B  C	
>   E  F  G  H	
>   H  E  F  G	
>
> (columns are drives, rows are stripes, LETTERS are chunks of data).

Presumably, this is the case for --layout=f2 ?
If so, would --layout=f4 result in a 4-mirror/striped array?

Also, would it be possible to have a staged write-back mechanism across 
multiple stripes?

Thanks!

--
Al

