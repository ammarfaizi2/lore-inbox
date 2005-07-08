Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262234AbVGHIli@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262234AbVGHIli (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 04:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbVGHIli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 04:41:38 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:16567 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S262234AbVGHIli
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 04:41:38 -0400
Message-ID: <42CE3C39.8060907@namesys.com>
Date: Fri, 08 Jul 2005 12:41:29 +0400
From: Edward Shishkin <edward@namesys.com>
Organization: Namesys
User-Agent: Mozilla/5.0 (X11; U; Linux i686; cs-CZ; rv:1.7.2) Gecko/20040906
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Louis-David Mitterrand <vindex@apartia.org>
CC: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: how to use compression with reiser4
References: <20050708081050.GA6608@apartia.fr>
In-Reply-To: <20050708081050.GA6608@apartia.fr>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Louis-David Mitterrand wrote:

>Hello,
>
>I just converted a server to reiser4 for a big speed gain. Thanks, this
>looks really promising.
>
>How can I activate compression on certain parts of the filesystem? (I
>digged google for this without finding anything).
>
>  
>

Hello.
Reiser4 will support a special kind of regular files - so called 
cryptcompress
objects. Unfortunately this is not for product using for a while, but 
benchmarks
really show a speed gain for some conditions (if cpu is powerful, 
compression
algorithm is fast, and data is compressible).

Thanks,
Edward.
