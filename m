Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314900AbSD2Ihf>; Mon, 29 Apr 2002 04:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314905AbSD2Ihe>; Mon, 29 Apr 2002 04:37:34 -0400
Received: from pat.uio.no ([129.240.130.16]:4509 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S314900AbSD2Ihe>;
	Mon, 29 Apr 2002 04:37:34 -0400
To: Soeren Sonnenburg <sonnenburg@informatik.hu-berlin.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: getting a programs ENV via ptrace ?
In-Reply-To: <1020068756.5050.7.camel@sun>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 29 Apr 2002 10:37:26 +0200
Message-ID: <shsvgaaew8p.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Soeren Sonnenburg <sonnenburg@informatik.hu-berlin.de> writes:

     > Hi...  I am looking for a way of getting the environment
     > variables of a running process.

cat /proc/<pid>/environ | tr '\0' '\n'

Cheers,
  Trond
