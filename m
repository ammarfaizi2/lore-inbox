Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316739AbSE0TeM>; Mon, 27 May 2002 15:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316751AbSE0TeL>; Mon, 27 May 2002 15:34:11 -0400
Received: from pcp607045pcs.galitn01.tn.comcast.net ([68.53.58.57]:43020 "HELO
	gibbs.dhs.org") by vger.kernel.org with SMTP id <S316739AbSE0TeL>;
	Mon, 27 May 2002 15:34:11 -0400
Subject: Re: 2.4 SRMMU bug revisited
From: Colin Gibbs <colin@gibbs.dhs.org>
To: Colin Gibbs <colin@gibbs.dhs.org>
Cc: Tomas Szepe <szepe@pinerecords.com>, linux-kernel@vger.kernel.org,
        tcallawa@redhat.com, sparclinux@vger.kernel.org,
        aurora-sparc-devel@linuxpower.org
In-Reply-To: <1022525198.19147.29.camel@monolith>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 27 May 2002 14:34:05 -0500
Message-Id: <1022528045.19423.6.camel@monolith>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-05-27 at 13:46, Colin Gibbs wrote:

> What kinds of heavy loads? If you were triggering the out of nocache
> memory BUG, then this patch may help. I fixes a bug where fork fails and
> calls destroy_context on the parent's mm or more precisely a memcpy'd
> duplicate of it. In that case when fork returns to the parent, it
> continuously faults.
> 
> But if your load does not fork heavily, then this is probably not the
> problem.

It seems this is in the bitkeeper tree, so ignore that if you used the
bitkeeper tree. However I'd still like to know what sort of loads are
causing you problems.


Colin

