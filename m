Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286237AbRLTNgE>; Thu, 20 Dec 2001 08:36:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286246AbRLTNfy>; Thu, 20 Dec 2001 08:35:54 -0500
Received: from pat.uio.no ([129.240.130.16]:43198 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S286237AbRLTNfk>;
	Thu, 20 Dec 2001 08:35:40 -0500
To: Samuel Maftoul <maftoul@esrf.fr>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: NFS > 2Gb
In-Reply-To: <20011220134414.A19648@pcmaftoul.esrf.fr>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 20 Dec 2001 14:35:32 +0100
In-Reply-To: <20011220134414.A19648@pcmaftoul.esrf.fr>
Message-ID: <shs3d26f1zv.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Samuel Maftoul <maftoul@esrf.fr> writes:

     > Hello, I didn't find anywhere a clear explication on the
     > question: Does linux support large file over NFS v3 ?  Does it

Clear explanation:

2.2.x
  No

2.4.x
  Yes *if* the server supports large files, and *if* the exported
filesystem supports large files.

     > works with a solaris server and linux client ?

See above.

Cheers,
  Trond
